Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDB97E365C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjKGIIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjKGIIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:08:14 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702C2129;
        Tue,  7 Nov 2023 00:08:08 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b497c8575aso5693566b3a.1;
        Tue, 07 Nov 2023 00:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699344488; x=1699949288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ttXqTP+4Vn5umWykt6+NuZt9O79QAnsU1LGP6YXU9Zk=;
        b=nOq+TIFdoZ9YDPP6S06U/qln8h+8+p6GvQ9CIwjanfZOItZ59CZ5730n/8+j6wMtSn
         65AFjC0Dcx1BejqRVFEBt+zXcBdSJ9w0L3FOetiD6uv1MesuUHognXnb24/zA8QUOC5I
         1j3106UoIN2lLkaZ5Lb86MVs7VerS9YwczgdUo7SMSz39N00kSKwQuMHpk1OPHJj+PJE
         zCfRo4HGjhJ3rp9mP/OlVscGeLcWZuXB3o8KU4Uf1vxeYZfQ+Ex0q9MtRQ6jwoi5CxuX
         OXZvkAp2zmWGhrJZhkKqccknNsdfmYDTHJqIp34d/3/KD9qxLjJnvnqH9N10qCsWHCxi
         VPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699344488; x=1699949288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttXqTP+4Vn5umWykt6+NuZt9O79QAnsU1LGP6YXU9Zk=;
        b=uyAPvyOJXKtM6CLlOHeG16KWN/3myp95PAMCK+X59RoHXdpH5vG8MWxwjtZB/MoOTZ
         rAAJNtE3ROPcwB4qMp2DNtn1jpZPA6SwYzlOm+4UA1ErbtarUWm14JV7ypqi8bXJKqe4
         3ujcNYtSzVYINsOWxgs1Cx6DSrEO7/r5/b7eg3jUTUPWlSvkhmuqPskxbOVklVDOeav+
         c8PtqFxeVHGRPhWtngjTIp4rAz80HKlv4TyFNzqPfEtScUV4T99En2zK9miMBz2Mm4hZ
         QaZtHcY54oLpCykP3VFf19bcsmQijsb1bOxpx5oKjVKQ2vGTUgW6ZEDOhgljlUWZfXQT
         cmkA==
X-Gm-Message-State: AOJu0YyXMa+JccRA+g3xN2QIgOSX7/GQQzbuJXXqTevU7boPE3XdpNLV
        ZxzWQvNj8ri2yHONtVQWqIyjG+z5cPeJ0A==
X-Google-Smtp-Source: AGHT+IGC5IkahBSjMohONTov0dfX7L8VtsuNs4X0P2KeXZfzd3gzSmHwdNM2Jbr2u4FrddXTkIPd/Q==
X-Received: by 2002:a05:6a00:2d09:b0:6bc:f819:fcf0 with SMTP id fa9-20020a056a002d0900b006bcf819fcf0mr37849993pfb.1.1699344487663;
        Tue, 07 Nov 2023 00:08:07 -0800 (PST)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id w2-20020a056a0014c200b0069ee4242f89sm6941581pfu.13.2023.11.07.00.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 00:08:07 -0800 (PST)
Date:   Tue, 7 Nov 2023 17:07:03 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     borisp@nvidia.com, john.fastabend@gmail.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ywchoi@casys.kaist.ac.kr
Subject: Re: Missing a write memory barrier in tls_init()
Message-ID: <ZUnwJwuqZMFNYE3x@dragonet>
References: <ZUNLocdNkny6QPn8@dragonet>
 <20231106143659.12e0d126@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106143659.12e0d126@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jakub,

Thank you for your reply.

On Mon, Nov 06, 2023 at 02:36:59PM -0800, Jakub Kicinski wrote:
> On Thu, 2 Nov 2023 16:11:29 +0900 Dae R. Jeong wrote:
> > In addition, I believe the {tls_setsockopt, tls_getsockopt}
> > implementation is fine because of the address dependency. I think
> > load-load reordering is prohibited in this case so we don't need a
> > read barrier.
> 
> Sounds plausible, could you send a patch?

Sure. I am doing something else today, so I will send a patch tomorrow
or the day after tomorrow.


> The smb_wmb() would be better placed in tls_init(), IMHO.

It sounds better. I will write a patch in that way.


Best regards,
Dae R. Jeong
