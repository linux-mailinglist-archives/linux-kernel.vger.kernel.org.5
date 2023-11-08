Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0347E516F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbjKHHyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjKHHym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:54:42 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED871712
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 23:54:40 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-778925998cbso423510285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 23:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699430079; x=1700034879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygNz6QaSQr8C1JwBdK820eTxi+sSDA3kL8cf+f1Y6x8=;
        b=UagEPHwoGn1cw7pvkgp2eJ6xAnmhX/aRnm25RpjTSVbUJ/8AQdK6Bbh2CJbrHIamsy
         6bhTy/VEm5/578iHDGUDWeNyvg1SY+u/gCfX3NA4ozrSskiuulNJKlKz4CgESPsmYNW8
         xrOrf6NWix0vxsv6qfd6WmVMYejw+wLv7lCQOuBTmBUaKcJyOg9aebQxSqDdMiRrZyI8
         +N9RihfaRB4L3nF+8dIje8gLMCVeLZPUY6Jz/5Of5KehN7YmCkLl8XtL1zwQLPGBT6bZ
         TG6qcwbQqF2hNEkpupuLaYHZPESBOJqaHIPD99uBv1NFYs4MGJ2ococ8HW+16x7oYgno
         K41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699430079; x=1700034879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygNz6QaSQr8C1JwBdK820eTxi+sSDA3kL8cf+f1Y6x8=;
        b=nFFb8f/yid7RKFxuiR4Y1gZmbR7tRVp5y9NDFHU7q9iw73L5Q3VXnJreM22VRjxQ6A
         iljZpI1TQ++SLT5iW64Qv0aJJdn062ZVHSqpvdaAqGaCqJ3auQH4CHkkAFxJoiFsR+bW
         cZjsdKED1vBGTzb9miGd3tfoqcD3GlUWfu/1eXGa9tQr7S3vrfgsrsu1HduH/DwbVSw7
         KJ6UFQnxFpEYw+qCePZ5Wa7iUDyieYghweqX6CcisA2LD0EyeGvRKk1vtYdOnptNZKUA
         X3VuEby/SqcnhwlO0N00hGQCa4vQP8z70Zm+Tfs8aRCJVpEziX2puUPgv9Er/0COG2Qk
         exMw==
X-Gm-Message-State: AOJu0YyQaJmt8tnLeMmy7pXyvmSJSnV5Fa7cbVtGh4asEhQPXQJ0Q1CW
        bfNfzWKz4yX+hSWtjdubLShTUes6AQ3xlOqaGZtolvA8BP9p5VTn
X-Google-Smtp-Source: AGHT+IH6cPAsrd3WC4bAwpwc11Q1TdPFwhf/pnW+2buoTZN3PIWXydcyrG1UcoT4jj32qxmHEZTzkOtQ6hXJsT/oSqE=
X-Received: by 2002:a05:6214:2622:b0:670:fa29:eb51 with SMTP id
 gv2-20020a056214262200b00670fa29eb51mr1104915qvb.12.1699430079490; Tue, 07
 Nov 2023 23:54:39 -0800 (PST)
MIME-Version: 1.0
References: <20231030085515.907123-1-etienne.carriere@foss.st.com> <CAFA6WYO4m5n9oTzP1zJdJXASCwXdhVaa_tMN2EhDTNDMmxwaJg@mail.gmail.com>
In-Reply-To: <CAFA6WYO4m5n9oTzP1zJdJXASCwXdhVaa_tMN2EhDTNDMmxwaJg@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 8 Nov 2023 08:54:28 +0100
Message-ID: <CAHUa44G2=tVXTqJxSx_bBf22FDp2LVBP1zk2bzGp+EvcUkTUrQ@mail.gmail.com>
Subject: Re: [PATCH] optee: add missing description of RPC argument reference
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Etienne Carriere <etienne.carriere@foss.st.com>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 10:06=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> On Mon, 30 Oct 2023 at 14:25, Etienne Carriere
> <etienne.carriere@foss.st.com> wrote:
> >
> > Adds missing inline description comment for RPC optional arguments
> > reference.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/lkml/202310192021.fvb6JDOY-lkp@intel.co=
m/
> > Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > ---
> >  drivers/tee/optee/smc_abi.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index d5b28fd35d66..67bfa25d6302 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -806,6 +806,7 @@ static void handle_rpc_func_cmd(struct tee_context =
*ctx, struct optee *optee,
> >  /**
> >   * optee_handle_rpc() - handle RPC from secure world
> >   * @ctx:       context doing the RPC
> > + * @rpc_arg:   pointer to RPC arguments if any, or NULL if none
> >   * @param:     value of registers for the RPC
> >   * @call_ctx:  call context. Preserved during one OP-TEE invocation
> >   *
> > --
> > 2.25.1
> >
