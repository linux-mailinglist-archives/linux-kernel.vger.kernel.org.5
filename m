Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C4480CAEA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343615AbjLKNZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbjLKNZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:25:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A52DF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:25:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE84C433C8;
        Mon, 11 Dec 2023 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702301145;
        bh=VKs1EvBmGIBwqV2FwfnKtoshqlh3tYuJXm/ZPmZw9mc=;
        h=From:To:Cc:Subject:Date:From;
        b=HtdhY6jFU/kTASHqTfLYT4x6ST54NyjoG3iXRxd3TyyTGiQxtkiy7dCdmMcfHtWzn
         pkIJhCpB/1B6TiLofbbMGpTQq42JpzfNOu5b1m8plSRfFFI1vA7yS0e+eQrtO9A4t2
         P1nv//3JLBryXto4tV/p3iu/0goPC7CorOhYa03i5fTEsdMNGQFTBKNJRKiR9Dow6W
         /6OnJaGPtKzVzNaXQAfb/YjqP7QSDMpfd1JeIda2s1QYKQZLDXtDs+jSOx4Xoz5ZJb
         nnw1YTxeJu7q3P7eWVEuCD9HrvzRM+xxgAaCrxeKaRUY9ekUurk4sunduxJnGUYPXd
         PV0ZkwXGujsYw==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1rCgIq-0007Ff-0Q;
        Mon, 11 Dec 2023 14:26:32 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        srinivas.kandagatla@linaro.org
Subject: [PATCH stable-6.6 0/2] ASoC: qcom: sc8280xp: Limit speaker digital volumes
Date:   Mon, 11 Dec 2023 14:26:06 +0100
Message-ID: <20231211132608.27861-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a backport of the following series:

	https://lore.kernel.org/lkml/20231204124736.132185-1-srinivas.kandagatla@linaro.org/

which did not build on 6.6 due a rename of the asoc_rtd_to_cpu()
interface.

Johan


Srinivas Kandagatla (2):
  ASoC: ops: add correct range check for limiting volume
  ASoC: qcom: sc8280xp: Limit speaker digital volumes

 sound/soc/qcom/sc8280xp.c | 17 +++++++++++++++++
 sound/soc/soc-ops.c       |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.41.0

