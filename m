Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FDC77BAE0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjHNOER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjHNOED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:04:03 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5658FE6D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:04:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bdcade7fbso567685966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692021841; x=1692626641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2tYT70QSADvKey9KGvE0OeVu+4Pc0bll8FUx1XFEc0k=;
        b=Y6/Pg10v/eMAJ47QaGFn8fHG5ZWmsBsXECHzC/cOW+aauVThwHvFr/K/KSf4yl0CkD
         JGdPfT23l03LduO0WcXQMxv59ERjEqiadP3CpXhEk2ncUwGrpfxy0tFmMjlZPZjsIasX
         i2rapg4LnyI/adj354368TE7iCYMfJ0Mw4xpxynT4VAq5A0gXg8SVwKBIGg/V+jKQBtT
         xxpbXk1hPCc3sp2jWTDUG8rnZTg6cQK359rZiyKigeUJ+ESZr5MQgewaDVWfXEi0cKKh
         AcXYnak0fIXCvd7fwm2npk030LuuamPlrkmx6zF4HoCRdrDDwNWmTrVFCiUjfG6/2VDC
         tafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692021841; x=1692626641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2tYT70QSADvKey9KGvE0OeVu+4Pc0bll8FUx1XFEc0k=;
        b=lAcLIVw+ZzbN1WcL7bfYTpvsp1tHO8CKMJlHjqCuCSh+qpJ8HZUAV5nJb1QXHZ3wGM
         +lPQ4cXCGATCOfpEfwb8MeEIvCMWYRjYoMV82k6Dz/+FcA020ccOM/rZcCTvFvQudyW/
         J6WbL9zSijzcITCU15Qur/6Abqq/BPh0jzwsUhp84GaiXXhHvsYYKWQjbo+UeMr7D1Mj
         wiEDSIc5BSF+8bGSScOpkCqH+uiuUOYpSl2RrtWsmYm2eNlzWwk0qNZPy9VjVLnzvzwC
         b6D1apKQcXPNwRMm+wd6ZUWn92wx54i5NrLg9cB3LaAqsqzKv+k5TdFmLyNoV0OA6sWg
         KraQ==
X-Gm-Message-State: AOJu0Ywy9rQ9pARXFUou9mPcCU9doqn1cOX2xeCGYCulY33Aj92xX+Nb
        lix07izwe8F0s2UjMbwk+7E=
X-Google-Smtp-Source: AGHT+IFPBeqS62+BAbDxMk76ReppLTfDmZdeYVPiM8FQMd6zx2Hr87kqNLX37RBdrArI04/01vCJzw==
X-Received: by 2002:a17:906:10d7:b0:99d:6dd7:42c2 with SMTP id v23-20020a17090610d700b0099d6dd742c2mr7337754ejv.40.1692021840744;
        Mon, 14 Aug 2023 07:04:00 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id gw4-20020a170906f14400b00993b381f808sm5672731ejb.38.2023.08.14.07.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 07:04:00 -0700 (PDT)
Date:   Mon, 14 Aug 2023 16:03:58 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        charlie@rivosinc.com
Subject: Re: [PATCH] riscv: correct riscv_insn_is_c_jr() and
 riscv_insn_is_c_jalr()
Message-ID: <ZNo0TvIOUIx3GdTm@nam-dell>
References: <20230731183925.152145-1-namcaov@gmail.com>
 <87o7j9g73d.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o7j9g73d.fsf@all.your.base.are.belong.to.us>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 02:07:50PM +0200, Björn Töpel wrote:
> In the future, add a Fixes-tag for these kind of changes!
> Fixes: ec5f90877516 ("RISC-V: Move riscv_insn_is_* macros into a common header")
> 
> (No need for a respin, b4 will pick up the Fixes above.)

Thanks! I will keep that in mind in the future.

Best regards,
Nam
