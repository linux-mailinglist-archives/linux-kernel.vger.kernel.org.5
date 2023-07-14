Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6DB753EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbjGNPT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjGNPTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:19:55 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F7F2117
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:19:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-98e011f45ffso252554566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689347993; x=1691939993;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRxUFSZUV2W8ort0PSj9hJsHbd6feENt4NCd2S7baGM=;
        b=kzPYOVXNMgXeOi1lmP8BNT3aG05tx9JwNSA93oBI+KA2rcVXavNhT42Py82GFw/dVx
         xYzuz/L+jSOIt+EP6ZuhbjyNgs1QRfCBMk7Eda1ciaG0WdtjCZ7fXYOtove8c1qdWyc+
         AoFNG0bOWYs9VyaqlEt1l0c44lS+SIjlmi3vgSCrkjzIPUjH3MZp3TaEJyO/sTIAFxWs
         8DzSW+1LsfzQ8sHkVpVRpZwcirdnwz1ClyrnYUHte4ah1GPfHYo3B+T4KZ8xUXnGqPMs
         6okwA3JsDmHSR4jKrnPKfZBRKSwKqq2jrCjaB9Xn5FWKS8yULHMRp2wDn9w9+HOopza1
         8Pqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689347993; x=1691939993;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uRxUFSZUV2W8ort0PSj9hJsHbd6feENt4NCd2S7baGM=;
        b=MY/oxZTOL6xNm5zFSN6Co778zVQz2lWydqPppvLXtDmZYMs8e2J2u3yvbv1cCLCR3H
         2OfG72ZPKIoNiNWA9rk0kJ/0wtJJgXzxG2LDguwrUlaX5x7GeseSiCK/1GXEK5TeaSaW
         mipwHDWe5S5mZ+fakrDDGRu+ueSJwlTnif1mORYIdFNTWzoW+SFzV5gjIK5ASBM4kVZc
         ZoM8UjEW9iWtlGHvFwtB/64duiBpaQL3AfEPeBQ0X2NHGQZRbV3mtXEXg09yMAEk+qtj
         zpej+OPFENNiEMOD5lSPq0JR+qcCDZ4HRTtDx3849rz6gmNiBbMy5JQ5jgDhdB5ZyNcV
         tX9A==
X-Gm-Message-State: ABy/qLa9GeGVI2WGy4m/Lq1hPjHUsmZpWCUuhxt8n23XcRK6LSPDOB5w
        WU5MurY8jX8YHPmYauwiTqM=
X-Google-Smtp-Source: APBJJlH/63xAD4d8jqV9NnNG5NHdtTn3OTwFVR/uDJ9N36uzE9gs//IK4CRQnYm5FFxhU/bq+faEQg==
X-Received: by 2002:a17:906:5194:b0:993:e9b8:90f5 with SMTP id y20-20020a170906519400b00993e9b890f5mr4483546ejk.8.1689347993197;
        Fri, 14 Jul 2023 08:19:53 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id e10-20020a170906080a00b00992d122af63sm5472518ejd.89.2023.07.14.08.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 08:19:52 -0700 (PDT)
Message-ID: <273ad871-9050-7851-9973-5545b88bf43b@gmail.com>
Date:   Fri, 14 Jul 2023 17:19:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 0/2] Fixes for Rockchip NAND controller driver
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie contains various fixes for the Rockchip NAND controller
driver that showed up while testing boot block writing.

Fixed are:
  Always copy hwecc PA data to/from oob_poi buffer in order to be able
  to read/write the various boot block layouts.
  Add option to safely probe the driver on a NAND with unknown data layout.
  Fix oobfree layout.

Changed V5:
  Reword
  Remove skipbbt patch

Changed V4:
  Reduce subject size
  Add 'Fixes:' tag
  Reword

Changed V3:
  Change patch order, layout fixes first
  Change prefixes
  Reword
  State that patches break all existing jffs2 users

Changed V2:
  Add tag
  Add manufacturer ops
  Reword

Johan Jonker (2):
  mtd: rawnand: rockchip: fix oobfree offset and description
  mtd: rawnand: rockchip: Align hwecc vs. raw page helper layouts

 .../mtd/nand/raw/rockchip-nand-controller.c   | 45 ++++++++++---------
 1 file changed, 25 insertions(+), 20 deletions(-)

--
2.30.2

