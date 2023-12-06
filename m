Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B44C8071DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378822AbjLFOLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378713AbjLFOLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:11:08 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7BFD45
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:11:14 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50be9e6427dso4889544e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 06:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701871873; x=1702476673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XNzSYcIp8QiaOcjyvcNVi0Ch8I0a7jbAWmfX7Yhtpd0=;
        b=CZbk6fxU0jY15FaedogZhImHt12+o6NU7wlBOEgAEP4zV4kavjKuPk8R7W4cE+wWY9
         PfdLsv2dNGu/cMXHzzCsw+kT0VNmTjrrT13XzRptPurskGOVhf3nCIPourUNeanX4uO9
         G4oYyUw7U5lgh5BRn106IUqrRa7JQQ8FDv0VipM/ubGRiH23c7SSByCYUJKYLMHF3dso
         Pm6w1icYJ854xKEHXWiRPy/QRFz+0S7BW4Rn+9BB6dHkYrantDgtWmfbmvdxNBhRK68z
         LF19U6Fm8OfeSS+g49bOHI0RE3swDWzErhmCLgVhPuyTCqE26M4qqFMIRdomPSmNGFIb
         FvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701871873; x=1702476673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNzSYcIp8QiaOcjyvcNVi0Ch8I0a7jbAWmfX7Yhtpd0=;
        b=KqAfqKrLMbnlCSNJiNHA3U710I0XS/s+Bsj3Lkbw+O1jaqUaCa5LgTVjM0noSzl14r
         5XRD0SZBG4yKDHSl8Ai3beP5G49lV/A9tEhrwfyAYbZlbGHOP3je1eej6AiiCaBlDKrr
         SyhuU9p0ls6of5Bw7pDhouHqPI4mpJy5xafE/XMr886KzDmIbECdbSNCvdWMipEwUJxd
         UVBX5trbglZkFgLlXiEfi/xPPFBnzXw4vb1IdHcYohZWXHEMSKM+F5LnwAT231C8RVov
         pHiAGZrjELvciXu7GKhBSXVqMK6bczZ7nOamX8//ocUS/h/RweTcURJOREetSUEIBbqu
         XUkQ==
X-Gm-Message-State: AOJu0Yzf6DLYyHmSGTDxMmMSbCnChLAp8q58w/lgucrhMzU0zRcN1c/J
        Q8z0pfm6jE2kDCuO8nFdtGg=
X-Google-Smtp-Source: AGHT+IFr8mTzAYUk/xKHbWpYQfDpnWc+Vbj0Hs9YDHLul5k8eoZUKHHTYZrUliaLKJTpZbBsj2McDg==
X-Received: by 2002:ac2:4839:0:b0:50b:f82e:6d5a with SMTP id 25-20020ac24839000000b0050bf82e6d5amr580036lft.73.1701871872294;
        Wed, 06 Dec 2023 06:11:12 -0800 (PST)
Received: from andrea ([31.189.124.152])
        by smtp.gmail.com with ESMTPSA id j10-20020aa7c0ca000000b0054cea9f91e9sm16557edp.20.2023.12.06.06.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 06:11:11 -0800 (PST)
Date:   Wed, 6 Dec 2023 15:11:07 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com, charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] membarrier: riscv: Provide core serializing command
Message-ID: <ZXCA+4WyI6D+Somy@andrea>
References: <ZWe+ljzCUQQVu7oD@andrea>
 <mhng-40f43849-e610-410b-92b5-7571838ce9f5@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-40f43849-e610-410b-92b5-7571838ce9f5@palmer-ri-x1c9>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I see
> 
> $ git grep "config MEMBARRIER" fab957c11efe2f405e08b9f0d080524bc2631428
> fab957c11efe2f405e08b9f0d080524bc2631428:init/Kconfig:config MEMBARRIER
> 
> so IMO this is just one of those forever bugs.  So I'd lean towards
> 
>    Fixes: fab957c11efe ("RISC-V: Atomic and Locking Code")

Works for me, will apply in v2.


> (or anything in that original patch set).  It's not that big of a backport,
> so I think it's safe enough?

Indeed, I think so.

The final version of this fix will likely depend on some machinery/code
introduced by 3ccfebedd8cf54 ("powerpc, membarrier: Skip memory barrier
in switch_mm()"); but, yes, nothing we can't safely adjust I think.

Thanks,
  Andrea
