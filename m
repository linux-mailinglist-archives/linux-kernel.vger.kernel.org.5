Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C8F7F9DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjK0KoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjK0KoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:44:09 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A4110F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:44:15 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9fa2714e828so550085566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701081854; x=1701686654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=maLf/n0rO7h34/VWW+Uh1BDkewzdC3UBO2BBtmtClZI=;
        b=AElOBEjNOs7XSaGPbGm7Y0upuOKv4fxmHsVQ1Dn6cypa7CmCZY1ob3UpB84sPGQRBu
         RGqfYlFRADPwP3LxUafS/WisHm5FSZzFIXqtUKUrHKRbptnbo0q+CL+KQC+TU2YO/TPa
         ebwI/b4wI2g+1FM4VabdrmZIXUwkug9g+UpUSw3TATUs42U2RQBPL7randU9zpVYQQgI
         SL0apQyNiDv6sARpJixoAZmHJAWSXq1w2RB+dQFMtzgaAkLBUCN+jfcLm13A4zofFvzs
         C9EHKOreNOmmAi3fr9XYVd1BX332OZGh7BcbkX8W7LZ9lI32sYIoTSa5Ab4PxXZ3pPsL
         L+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701081854; x=1701686654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maLf/n0rO7h34/VWW+Uh1BDkewzdC3UBO2BBtmtClZI=;
        b=obeflA7a0BTT5M+xsNHxKAxrF+YdYCNyaczfjwj31MdnKL6pqVcVwJqKH33p4LIzZO
         ixaTthdMEbb0qBN1gaTVCSoKi3xmCLNk8g9kgdia9FULPIe7vO6pPv34ROizEbvpAcMt
         rjmSgHnB2uZtL5cJfByhM55YPtIvgFzaJylGQ0EI/pH5DcQ3FauxQS2lEn8um1/MAof8
         2iHS45Ba12Z9l3igXi9R/sOW+G94+LRN9A0nFcwwyd/iYpHIdjRpwkZH7e8llBg3kYGf
         7kSYldoMnWuIxlPKTRij+Jaz1a8XP1uze4Yw2t4cF+31WuIaXkX/vss3tzxyXtTE3GSM
         dF5g==
X-Gm-Message-State: AOJu0YzlV9VpRuCkUuRwUrheBy+W5OHbJgaxDAUYWCc356OgJvZdPAq2
        4mEEQdT2yJsbdmtskDci/5E=
X-Google-Smtp-Source: AGHT+IEdM+j0ztp6LCnNavmN9Ryh5bNIc0a0EN/Uu7itFKT3TCiooW66kHo1LBhqCdiFDC+eG4WAGA==
X-Received: by 2002:a17:906:74cd:b0:a10:dc00:c6d7 with SMTP id z13-20020a17090674cd00b00a10dc00c6d7mr924975ejl.0.1701081853656;
        Mon, 27 Nov 2023 02:44:13 -0800 (PST)
Received: from andrea ([31.189.63.178])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906119400b009fbdacf9363sm5509749eja.21.2023.11.27.02.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 02:44:13 -0800 (PST)
Date:   Mon, 27 Nov 2023 11:44:07 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, rehn@rivosinc.com,
        paulmck@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com
Subject: Re: [RFC PATCH] membarrier: riscv: Provide core serializing command
Message-ID: <ZWRy9/MD4nTAqEW5@andrea>
References: <mhng-b720eb90-633f-498b-a487-0cfdc9f00ddd@palmer-ri-x1c9>
 <65e98129-0617-49ca-9802-8e3a46d58d29@efficios.com>
 <ZU0sliwUQJyNAH1y@andrea>
 <ZV6lxsRmuN7bYFnD@ghost>
 <790b8b57-43ac-447a-96b9-150e5b3a4237@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <790b8b57-43ac-447a-96b9-150e5b3a4237@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This looks good to me, can you send out a non-RFC? I just sent out
> > patches to support userspace fence.i:
> > https://lore.kernel.org/linux-riscv/20231122-fencei-v1-0-bec0811cb212@rivosinc.com/T/#t.
> >
> > - Charlie
> >
> 
> Hi Andrea,
> 
> Yes, please send those as non-RFC patches. They align well with my
> intentions.
> 
> Thanks!

I've just sent them (after some editing to address the 0day report):

  https://lore.kernel.org/lkml/20231127103235.28442-1-parri.andrea@gmail.com/

  Andrea
