Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA3B7D94B9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345673AbjJ0KIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345629AbjJ0KIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:08:22 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02DD1A1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1698401298;
        bh=SPAGDpDz2k/2kguqhl8Z+gROPqCD/5aODXVh/os0Cbc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HsM795jWPXFnOnk0M1FPzOceaIeclRS7j+TcuJss3VixbC04tSeLgjThN7oHVcDLi
         TvW6YzJOFCT1sRaPssBNOI3ddyGhtpM0acR40OeGby66ZXLP20pDvbs86B8DCVbvaA
         KR7r730jGpBM6AQGUts2roI91Xp56sasQmAcDC6VMRTEY2vRvtJ+R+MtZwzJKmxvkP
         529z1y4d4/lNQt16aSpoPWpDOKd7tdlDq3mevSGWTy/zXXIaqOuyceWb24Jv13eimZ
         BoPkuUk3LkXnYOPrPmq5X1BhthZe33jH6Yz14YkFKnvCOAJNu4JsQTGg1LewmFb2yl
         dvaM6WSsNGgTQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGyzQ1RzFz4xWb;
        Fri, 27 Oct 2023 21:08:18 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Minjie Du <duminjie@vivo.com>
Cc:     opensource.kernel@vivo.com
In-Reply-To: <20230717092648.9752-1-duminjie@vivo.com>
References: <20230717092648.9752-1-duminjie@vivo.com>
Subject: Re: [PATCH v1] powerpc/pseries: use kfree_sensitive() in plpks_gen_password()
Message-Id: <169840079685.2701453.1853260380342531870.b4-ty@ellerman.id.au>
Date:   Fri, 27 Oct 2023 20:59:56 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 17:26:48 +0800, Minjie Du wrote:
> password might contain private information, so better use
> kfree_sensitive to free it.
> In plpks_gen_password() use kfree_sensitive().
> 
> 

Applied to powerpc/next.

[1/1] powerpc/pseries: use kfree_sensitive() in plpks_gen_password()
      https://git.kernel.org/powerpc/c/ca2b746d5f91a37f01baedff54b9315a50ee617d

cheers
