Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DD97F1767
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjKTPfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbjKTPfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:35:04 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916C5C8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:35:00 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6ce2eaf7c2bso2825181a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700494500; x=1701099300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/g2rj348QGTaMUoHfAitiDG5ZGAAe3AXrQUt05vFuko=;
        b=GeZBjfg2nIo1ZytF+4ndL+wFIZvPeDVWQHvWMaktOXyT5IMI/9nx9o8A0o7VB0OI6z
         Zr+CCaHURd1B7wTQ1VRNxKD1ZVj0EyyQcDCGMYnZ3ms9OMCuIC4JELEWu7eIp33KoU9f
         meeALvkxWqMBolyPs8NA5ZnQFvqFLI28rp+kRmPpl4qE6Q98X5EwqgC+xO38zE6ndrLp
         iEbJ+lXP5SEbkYAHXKkoOHpiPc1JVldH4Wq0swCrDm788u4XpMy8RQyzW4w6G0Kwbd3e
         E2B/H+dLO392YHZiIPXzI7rUtYo496DtWijYRGLKjH5PVY1rl6jtRRfQB5XNPAWdh17m
         5pwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700494500; x=1701099300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/g2rj348QGTaMUoHfAitiDG5ZGAAe3AXrQUt05vFuko=;
        b=A2fxdAZcLjR9Vj9n0DajhaAvdkxxzVGqn/v/3PoKsmM8orRmBnQ/7erQWFqbp8KvFP
         6T8A2/zqSgDM1X6f8tjkb8nnbYPclCbGzBsh4m3ojOowaISCua7GK+WMtB9LI5fw3mP6
         x/eBS8wY75QdpmINccu8Ry2Z3/+2WP+rCcMkBUS9XLCaDacQoWQFm7EVl3M+CNJs3J8j
         fr7RPbCIkarwm9n7BmqkUxWy8MmX9lsaDMAi2KgXtKBuJC9YAfQ1t1TuF6b2UNW54VAM
         2hY4ZMJEkLr6HJeGETERxFDwRJX/3tkrGctZyBAOdTJP552tjm+MUJ1J3hbEf7HyKTTw
         RC9w==
X-Gm-Message-State: AOJu0YxJTqU0+qiR8y+AmT/B5WaIdIubMdx0razYZEhLFSNozoJgUMur
        DXJXkglgWD951lxI0GnIOOuF7RyhmJOTRQSi3gfrSTcIyEJSpURk
X-Google-Smtp-Source: AGHT+IEb/1/SLpzTzhneVYblRJrocGEMu2RdIxrcZxKtNKLCJyFuPBDDmOa2CJDUAEm6395K+9ibzZoeZAOLMtUfDtg=
X-Received: by 2002:a05:6359:2eaf:b0:16d:bc40:3055 with SMTP id
 rp47-20020a0563592eaf00b0016dbc403055mr6273826rwb.19.1700494499834; Mon, 20
 Nov 2023 07:34:59 -0800 (PST)
MIME-Version: 1.0
References: <20231103061715.196294-1-sumit.garg@linaro.org>
 <CAFA6WYNW_cAFVMTpqPQjwBASKDp_b=CpccCzx23jHn_+qoJrDQ@mail.gmail.com> <87y1es5xsd.fsf@meer.lwn.net>
In-Reply-To: <87y1es5xsd.fsf@meer.lwn.net>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 20 Nov 2023 21:04:48 +0530
Message-ID: <CAFA6WYN7ZB0Sgc0gB1rQhhirjoOEeyp2Uokzpwy-KFQ_aJQEVg@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: Destage TEE subsystem documentation
To:     Jonathan Corbet <corbet@lwn.net>, jens.wiklander@linaro.org
Cc:     vegard.nossum@oracle.com, Rijo-john.Thomas@amd.com,
        balint.dobszay@arm.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 at 19:31, Jonathan Corbet <corbet@lwn.net> wrote:
>
> Sumit Garg <sumit.garg@linaro.org> writes:
>
> > Hi Jonathan,
> >
> > If you are fine with this destaging TEE documentation patch then will
> > you be picking up this patch? Or would you like Jens to pick it up
> > with your Ack?
>
> I'm happy to pick it up.

Thanks.

Jens, can we get your ack here for Jonathan to pick it up?

-Sumit

>
> Thanks,
>
> jon
