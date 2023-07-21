Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313DF75BF2E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjGUHAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjGUHAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:00:00 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F845270B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:59:59 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fc04692e20so14022535e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689922798; x=1690527598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cMdrqooyWKqxdTLZ4iD2/9uda0+BohGDRw1+oGm+Wxs=;
        b=b2w37NYiNqObUrnUOJoN/Ki7gxvv8RV5P8wxZgITvls4FnsfqNeaszQpTEO/YPXn6F
         TVnddCcU1jsWn7HABRFksFYzEBpNwDhsGHZB8aSsj8WS3wiReIDzwWmuiYKqYnz/UssN
         EvGgNyRSODHxdfZMt5o8jgFwXiM9Ww23OJCvQpzlG3Ljq7+52acD/QnfB8VNCs/HymLq
         1l7Ga5Y6z14LH+gk57oSwkvq3/06EtY8nxTrYkg0276GOPfhSjUCkmhoXSB5iHKt8OEN
         YwIfyGwnicG/KO9/7EdC8OrEDuHzPgNWtYYjFe5rtIZ+Q2b4VFvUR5K1oGr1g5NxZwAs
         g5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689922798; x=1690527598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMdrqooyWKqxdTLZ4iD2/9uda0+BohGDRw1+oGm+Wxs=;
        b=RO10L/xYEFv/wdUL9cbzvy5VDkIfP6XEgVAy8jpXMUeyATbrD7QP50Cl8pZmHAewwu
         aRQzTQfqZFGXucWTu5V2bGLi426saHXq4bq5lQL4MFRaBTloRABW+tW6BxVk9N1PE2SB
         6iJNGbax45c+lWb4MKSz7hXduX9gggZt61DdTf94E0//U3sGaBiNsy99jlpRY+od/LCM
         GSgyAbI4w239bhX/5WrALQwnG2Kv3ZgEoXOpKrJMQvf/FVv/zqyg3mbuLLue8Si0sU8U
         j88USNBK/TY1osselTTG+vDWJYJSsnNwIxY0fnUdMMijSLhTxx6AJlOI1kmy02G1WjN4
         BTJA==
X-Gm-Message-State: ABy/qLbq16EsnXGFbS7lYW/K60iw+D+tIDoAWVZiinQ+4zJHBqVgGLVu
        gaf5yr/7juhWLW0RUx77qEYwuw==
X-Google-Smtp-Source: APBJJlENcMCQE+vF7Mm8olbbTa9ERp9pLxe/B4KBzog7/zYTMzoUX5fABPfgbpcIq8Co9gK+iPBrhQ==
X-Received: by 2002:a5d:4a0b:0:b0:314:4ba7:b024 with SMTP id m11-20020a5d4a0b000000b003144ba7b024mr722969wrq.9.1689922798057;
        Thu, 20 Jul 2023 23:59:58 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j6-20020adfff86000000b0031274a184d5sm3301652wrr.109.2023.07.20.23.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 23:59:55 -0700 (PDT)
Date:   Fri, 21 Jul 2023 09:59:52 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mtd@lists.infradead.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Harshit Mogalapalli <harshit.m.mogalapalli@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: fsl_upm: Fix an off-by one test in
 fun_exec_op()
Message-ID: <3319d61a-08df-42c0-8882-5d4c9037f5e3@kadam.mountain>
References: <cd01cba1c7eda58bdabaae174c78c067325803d2.1689803636.git.christophe.jaillet@wanadoo.fr>
 <6f3c9139-cf68-4761-af06-462a72bda978@kadam.mountain>
 <03c69172-b85f-d9c2-6fd4-33f3ad149142@wanadoo.fr>
 <604b0c70-01cf-4cbc-b387-8c709c972fef@kadam.mountain>
 <587c59c1-17f2-4c16-b2b7-1b1208e7c128@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <587c59c1-17f2-4c16-b2b7-1b1208e7c128@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 09:55:02AM +0300, Dan Carpenter wrote:
> On Fri, Jul 21, 2023 at 08:37:02AM +0300, Dan Carpenter wrote:
> > Harshit and I were mucking with this about yesterday.  He made
> > Coccinelle script as well.
> > 
> > We found three bugs in max9286_parse_dt(), hisi_inno_phy_probe() and
> > jent_testing_store().  Only the one in hisi_inno_phy_probe() is real
> > life bad because the others do an out of bounds check followed by a
> > mask.
> 
> Actually wait.  hisi_inno_phy_probe() is not a bug at all.
> MAX9286_NUM_GMSL and MAX9286_NUM_GMSL are both 4.

Gar, wow.  hisi_inno_phy_probe() is a bug.  max9286_parse_dt() is not
a bug.

Smatch would have found max9286_parse_dt() if it had been a bug.  The
reason why smatch didn't find hisi_inno_phy_probe() is because of how
Smatch takes a short cut when parsing loops.

regards,
dan carpenter

