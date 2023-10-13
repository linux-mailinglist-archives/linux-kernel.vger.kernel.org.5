Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733477C7B77
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 04:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjJMCD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 22:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjJMCDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 22:03:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF05FCA;
        Thu, 12 Oct 2023 19:03:20 -0700 (PDT)
Received: from mercury (dyndsl-091-248-212-229.ewe-ip-backbone.de [91.248.212.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 08EF7660735B;
        Fri, 13 Oct 2023 03:03:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697162599;
        bh=tuNzyGDEu1v+l5lllc4ysrPhH5ok6L1sMzLUROzKTMQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gmbclGuoMihxqpPfBsW2q4QFqODVSRTESdQ1j1ohNMSJk45eFSNR+ph/xTQbOHMvm
         zpbQsxLjUDrdhH9EIdArrJmc2GZDOCTctPeG3UGDbWONiy2vqVrnq0IkKKdJAzuyHY
         1U+jKDnBGTuTmF+y/J9cXmLHquoOBQP9wOiCXxkj+eH4QnRL8nStTxmhDlp4V4Jt4u
         sTEM1MX28Q7Ye6x52Iia35UX5HcXzns3LwLg7piW6M1meBjKS65g3SEjYYSOtiavux
         hBOKdGzMBTeVwv3WcoJK+0oc99XnD5hRSlr2K7Oa2aKtHwliwueRZedjRzfErRGlKF
         P+hPHzuvTJ85Q==
Received: by mercury (Postfix, from userid 1000)
        id 7F3DC1062B59; Fri, 13 Oct 2023 04:03:16 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231009172923.2457844-20-robh@kernel.org>
References: <20231009172923.2457844-20-robh@kernel.org>
Subject: Re: [PATCH] power: supply: cpcap: Drop non-DT driver matching
Message-Id: <169716259651.1002132.11843544877394485261.b4-ty@collabora.com>
Date:   Fri, 13 Oct 2023 04:03:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 09 Oct 2023 12:29:15 -0500, Rob Herring wrote:
> Only DT based probing is used for the Motorola CPCAP charger driver, so
> drop the !CONFIG_OF parts and redundant of_match_device() call.
> 
> 

Applied, thanks!

[1/1] power: supply: cpcap: Drop non-DT driver matching
      commit: b3c3a197baf23ca445ba74e3c7c40cfacfedd9fb

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

