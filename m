Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D03578D2B3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 06:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241863AbjH3EIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 00:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241861AbjH3EHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 00:07:42 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DC791
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 21:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693368457;
        bh=6ZQzSMSN28+kbKnmivGKqghjLsCAs6sPBNx9kR5DHp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PDZnT4gXhIlk9rHk37qaRSKw1Z23cDGw9ZdzvOMPdV1lFgOOKUuDGsbeaQJIzZs6z
         7hgxvgI8qJtIeupPKd6hBe8WGjgVtj3SldXzspr5P5G2nMMoymYaNtCNPUofyqjOtL
         ujTkJUf4mVayDb7zY9TLuQ5slGprakUNiDs91wNCWN+QWjSyoo1VIBzNp3DYi3un0d
         zxnCYCMmeT3gkI8/GMypVVaqxklNqQw1+tliQdZbVMMO85Y4NB0GKeGC6j8+YShUAI
         0T8+IcPDiIe/c3Ly9ulM+U8vB2Dqg+XpJS5a+h5X5TIzHjQrOBZzfu/YxP3oZ70U5h
         sbFe02sRwaE0Q==
Received: from gnuweeb.org (unknown [51.81.211.47])
        by gnuweeb.org (Postfix) with ESMTPSA id CFDA7249639;
        Wed, 30 Aug 2023 11:07:37 +0700 (WIB)
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Zhangjin Wu <falcon@tinylab.org>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/1] Fix a stack misalign bug on _start
Date:   Wed, 30 Aug 2023 11:07:37 +0700
Message-Id: <20230830040737.3601108-1-alviro.iskandar@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZO67TAOhJkrtp1uW@1wt.eu>
References: <20230830010223.1875339-1-ammarfaizi2@gnuweeb.org> <ZO67TAOhJkrtp1uW@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023 05:45:16 +0200, Willy Tarreau wrote:
> Thanks Ammar, now queued into the fixes branch.

Reviewed-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>

-- Viro

