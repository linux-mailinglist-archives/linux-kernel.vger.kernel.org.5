Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5EC80D2DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343944AbjLKQxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbjLKQxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:53:21 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFECB4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:53:27 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9f559b82cso53888841fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702313606; x=1702918406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oGddqI5Zh7BKNJ5lQo7xaF0k9wunTr0qscdYg3vG1Yk=;
        b=QE4daIQSIS8MGOOP91PX9unknDS45jBc/1ZYpvDXimgi54Y1Zwfx90s9W+EbmvJhYY
         +ZNqk0K69/q7vYfiTd0k0ho/UqijdMHjxpI7hQFAR+8HqL5tZ/DJekkXRjbhDpX9Pp+l
         x6bIzzVJmIUEYnVRavfszEZWohX33vFD4qIGYVFzJCYUpqfXeyn80YQfKBEGht22E2mI
         epqptqCH0c4qUT63tTGKwXTg1muXR3OZ151FKknxdATWYACr2FNDLNJwSWzR8VYqdVPR
         EvGgG86bZ61iQ1pqd0XqMZzR6zY3gc5mupKudy0rvdCgpG6yk6OIgd0wPBoWANez/bqV
         mPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702313606; x=1702918406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGddqI5Zh7BKNJ5lQo7xaF0k9wunTr0qscdYg3vG1Yk=;
        b=xITKPJ7oVEiPiigjGnRtobDpIkYYvHy4mgnZF4+DThiOrT+TDSFMwZpn6tkCeut/FK
         ljV12zsjBX3w+6EolHqrnvz6sxK5Kupln9Ih3FXUn2jAmLdNFMQDXTz60LvaGDXAefh+
         kVG+0E3o0Yz0l7weT+8joS/NaVUnYYYGbfmq8D04GXahOGz6/3H8QCAKXzusSdrxwUfc
         ENriDMEma4akEbttbsUE5AsKj601nrZ2O7ZW/9yCUaobLJOAgOhhbjUXH8cbkZdzrbLK
         x/h78JsLRInY2+5lnqOEDgOnDYSzxW+9XUbBw9hYKs4ykQRvlIrywulc69QTms8KAtaz
         w78w==
X-Gm-Message-State: AOJu0YyUHImT2PUBgojmdxzvV3G4PL0kR3qoLaf2NCDpLmRIWWSzjatx
        g86UuFFK5a1mFOmLs9pCXfM=
X-Google-Smtp-Source: AGHT+IFw9eceTa6fAq9hZRAsUzYF2zlfoHj4if+mUWNeRnKU/BkEdLUV/C4WR9mP+X2DQyTjqME3Bw==
X-Received: by 2002:a2e:930c:0:b0:2c9:f83c:5bab with SMTP id e12-20020a2e930c000000b002c9f83c5babmr1837720ljh.65.1702313605201;
        Mon, 11 Dec 2023 08:53:25 -0800 (PST)
Received: from andrea ([31.189.124.152])
        by smtp.gmail.com with ESMTPSA id l12-20020a056402230c00b0054c7aee67acsm3822084eda.97.2023.12.11.08.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:53:24 -0800 (PST)
Date:   Mon, 11 Dec 2023 17:53:22 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com, charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] membarrier: Introduce Kconfig ARCH_HAS_MEMBARRIER
Message-ID: <ZXc+gpayQTUT22t+@andrea>
References: <20231211094414.8078-1-parri.andrea@gmail.com>
 <20231211094414.8078-5-parri.andrea@gmail.com>
 <8132d732-b9e8-4a52-be5d-74db7a159136@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8132d732-b9e8-4a52-be5d-74db7a159136@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 08:34:21AM -0500, Mathieu Desnoyers wrote:
> On 2023-12-11 04:44, Andrea Parri wrote:
> > Architectures supporting the "private expedited" membarrier command must
> > select the Kconfig to use the command.  Document status and requirements
> > for each architecture in a single file under Documentation/features.
> 
> Sorry for being vague in my suggestion: I did not intend to make it
> optional (not ARCH_HAS_MEMBARRIER), but rather just to have a central
> place where this would be documented.

I see.


> I'm not sure where in Documentation this should land though ?

Not sure, perhaps a section in (a new) Documentation/scheduler/membarrier.rst?

  Andrea
