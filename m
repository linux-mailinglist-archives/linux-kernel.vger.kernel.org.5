Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC647A55A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 00:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjIRWKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 18:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRWKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 18:10:19 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F078F;
        Mon, 18 Sep 2023 15:10:14 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bf04263dc8so3391725a34.3;
        Mon, 18 Sep 2023 15:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695075013; x=1695679813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j/m5ZRpEcE48QJwBxR0VRFWuVl/PLiBICa5NN6cLqa4=;
        b=m04R8GUK1Pg5Y0yFp0ZryqmCp963dCiHGU67YJrkefrM8qb/gWxPcajCfDIdaYJ9tI
         Pw5oeq+gs6/VidshBlJZ1EALmIH2yCu5OGrPzrDo+dq/zIrmnsNgzwyR0xuuotwCeUYv
         tS/PklIlQg6RC5Mr9ZiBtfWehu/eS7xPEXkOGRmm8arOQXIKRU0fCE0LFJYN6c0eTJ39
         O48gMikGCLKh7GclBuPl1il1StMc+yOS9M2kpSN2STBKH8amvCrnx3i0TEcnqSPefCwf
         qIJztQ/T3f8oqsJBBTE8Hfk7rAPEYJcAmiuDsA5tGeZR1W5qM6ZzA2CXdUThmqZT6Ejt
         XglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695075013; x=1695679813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/m5ZRpEcE48QJwBxR0VRFWuVl/PLiBICa5NN6cLqa4=;
        b=p7swFcePjDB6WWX49BQJ1oSdgJ5ypiL+JdgnHZGl9enaehEMk8oUecJ+OVXcnmgyww
         GmyG9tRsIE4nCQM+Hdc0XsSeQm+am8qF1xV1DSciM1kMe3LEi9anlcl3GUaqSWCNS0uH
         YroZiZqLy00n9VmZek14WiG8JK9pw5qFc7pteyc5ryEq0iiIrNtPewkSNUrsTRZmL2Eb
         CBJSNxjA4a/aQXQzRU0SX8K56/1KoS/dQHcxs7AWkFxUSZo12mxj2c8SNQ7V5ZPUXVvX
         qc59Fqcz+lapKr7/5h3agf0CF71n2N8pHOA3i+pIG1G+u3t0ewb/xKAK6zo5v3HEQzmw
         CuBg==
X-Gm-Message-State: AOJu0YxedBzGNvsSETAyCR8X+1+t0or4qMAW7dieEv12NTLaHB4HvbMv
        zwc9u3MahrzyFtlur9K0cZ4=
X-Google-Smtp-Source: AGHT+IH+1ID9ELhlZc/ty9+BHrDnkB48wgXVsBHcq61dekjHU1+YBkxOJ0QjjD1fqj4RO5OiNbTTgQ==
X-Received: by 2002:a9d:66c4:0:b0:6b8:7eef:a236 with SMTP id t4-20020a9d66c4000000b006b87eefa236mr10457352otm.30.1695075013119;
        Mon, 18 Sep 2023 15:10:13 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:7a05:887a:3eda:bd6d])
        by smtp.gmail.com with ESMTPSA id y4-20020a63ad44000000b005777a911342sm1095478pgo.59.2023.09.18.15.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 15:10:12 -0700 (PDT)
Date:   Mon, 18 Sep 2023 15:10:09 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Javier Carrasco Cruz <javier.carrasco.cruz@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com
Subject: Re: [PATCH] Input: powermate - fix use-after-free in
 powermate_config_complete
Message-ID: <ZQjKwQDKmU8L9C9e@google.com>
References: <20230916-topic-powermate_use_after_free-v1-1-2ffa46652869@gmail.com>
 <CAPnbTwKqNghcoPj-FGQQxo0xr-AYTm8pYBYCUgyKT6VxZpZCOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnbTwKqNghcoPj-FGQQxo0xr-AYTm8pYBYCUgyKT6VxZpZCOA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 06:51:49AM +0200, Javier Carrasco Cruz wrote:
> Hi,
> 
> There's an obvious error in the patch I introduced when cleaningup
> (urb->status should be used instead of just status). I will send a v2.

I think what we need is call to usb_kill_urb(pm->config) in
powermate_disconnect(), right after call to input_unregister_device().

Thanks.

-- 
Dmitry
