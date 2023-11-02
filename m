Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37E97DE941
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbjKBASw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 20:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjKBASu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:18:50 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E34FDB;
        Wed,  1 Nov 2023 17:18:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6bcdfcde944so94208b3a.1;
        Wed, 01 Nov 2023 17:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698884327; x=1699489127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s8957ZXAMokJVu3Z7wnJ8VE74hgqLOzUJ6al4SM64Ng=;
        b=JKkP9IYbru2m2sGLIKUPz/TIVekLUsqWanPUqh5f8Ht0fOUS1yxZyAd0MjiNirMb7u
         0uCJD17ETntvRXi015vO+xfzMvM2BVk7k8PWSGEa7WhmumWfIeuC6SjzIu+Q7LfchdY4
         Lkvn6e74KrAQlxEO0USCjRY+n74vi7Dm1ldUFhfd4bQQyJFYmDyqOXuwS+BY3COnU8zt
         PTUNSpwFpqK+V//oiEVBzwKt5z2XAd8VmUj9JO780C6vsHL9aqiIcSSEaQKZkW5TEDwO
         CAL4Cm4JrEgPN/Ewz6lCyC/cvT+Pid1A2fTD7bj3xngWC8l//k2dXlY/kIn8xGtudWgt
         VClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698884327; x=1699489127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8957ZXAMokJVu3Z7wnJ8VE74hgqLOzUJ6al4SM64Ng=;
        b=gpBBclWMdjx6c/zXCSIxkYGExGABZuCV9xGDy25rayHQcdX4MktB39sd/jMfr+MDzt
         gcHu8kZJwBohIC6NCFriN+YRNi80a4uPBoxOA3P54sNdQdQBocJgiTlh7mvbSU4c07Y9
         unk29A+3/EGD+bvSA6h+JDnAxCjqBZC7J99NEBuX4qUQPwI4dK8xmsxiwShc3cAU/3rJ
         RL/+X/67jzW0TQxzXR2e2ArCZdFdsA8ymn1Hm3Gr1xsfjZohtNh6wQTmKK+xXzNTSBAe
         nIOGzNq3ZcUQq1SJ6Uq1EcSG3PWLyr8UCR+0OtitpCECZzcBfTj4LNz/nGr/qKuPWpEh
         xxug==
X-Gm-Message-State: AOJu0Ywd3jpry52lZdooUO2F45DvevLkE4401LzyKONRJq32wJ1Ndhfk
        4tsUeKovcOVzVB5IlE6Hg5Q=
X-Google-Smtp-Source: AGHT+IFflYaHUWBqCJRXS9+gKRfaZkgRQi57kLnq0Fw4deD2a8UANa0uI1zHkwc6lO2flirPhblOmA==
X-Received: by 2002:a05:6a20:2d22:b0:163:c167:964a with SMTP id g34-20020a056a202d2200b00163c167964amr20592204pzl.1.1698884326940;
        Wed, 01 Nov 2023 17:18:46 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id l13-20020a056a00140d00b006c2fcb25c15sm1583592pfu.162.2023.11.01.17.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 17:18:46 -0700 (PDT)
Date:   Wed, 1 Nov 2023 17:18:44 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     habetsm.xilinx@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        reibax@gmail.com,
        syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net-next V2] ptp: fix corrupted list in ptp_open
Message-ID: <ZULq5ILoM07oH1wr@hoboy.vegasvil.org>
References: <tencent_2C67C6D2537B236F497823BCC457976F9705@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_2C67C6D2537B236F497823BCC457976F9705@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 06:25:42PM +0800, Edward Adam Davis wrote:
> There is no lock protection when writing ptp->tsevqs in ptp_open(),
> ptp_release(), which can cause data corruption,

NAK.

You haven't identified any actual data corruption issue.

If there is an issue, please state what it is.

Thanks,
Richard


