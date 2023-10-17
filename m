Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB597CC085
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343715AbjJQKSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343855AbjJQKR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:17:58 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E372210CE
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 03:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1697537828; x=1697797028;
        bh=ufSCWYVk0+H4CDuQnLPLONYp2PW1XKTS7lo4/zj2kMY=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=Mmgp7HXOu2jk1PQmMAbaP5xWLW95BC8nNGa7Dc8e4d6azHhDMAB4U27IzzT+lYgjE
         ZMDTwGlUXx4nyTp8HB8tGdyltMjHKhpXr/HaAgbzJ3OPKAfbSntOJDEwTpdXzZU/0O
         GSgYT1vzopX/xGbv2YDG70JqWEIHSwwAMO6vJ4wYSrh0Dfr3ySA4sXecSgli9DS7kK
         Pr0MZbBUVU89iYJsx5CSj+fEj0JOilez5/+e3kPZQouAhzGCkUdRxp96a/El5Rx9NJ
         Hj36TXK2FpDAC1Ywzw+ApcIyO5zVScq6rwZNa9hWwEzyR6BAIpPiCw2kmH96XmU1+J
         HjgdU5she59Vg==
Date:   Tue, 17 Oct 2023 10:16:37 +0000
To:     linux-kernel@vger.kernel.org
From:   Raymond Hackley <raymondhackley@protonmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 0/2] ARM: dts: samsung: exynos4412-midas: fix key-ok and use Linux event codes
Message-ID: <20231017101402.62740-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Input event code 139 stands for KEY_MENU, instead of KEY_OK as node name
key-ok inplies. Fix it with correct event code 0x160.

Use event codes with linux-event-codes.h included for input keys on midas
in addition.

---
v2: Fix the event code before applying linux-event-codes.h

