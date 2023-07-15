Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2268754CA9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 00:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjGOWKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 18:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjGOWKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 18:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C30E272E;
        Sat, 15 Jul 2023 15:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAF1F60C4D;
        Sat, 15 Jul 2023 22:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F97C433CC;
        Sat, 15 Jul 2023 22:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689459012;
        bh=m9k/7693f/iEcpf5fwW8hI4eURF+/EDGTRckzZNi1eI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p6nlVFq8JOYdEdv0yXkkA7KJaco5z0pRVvIFaTBuJFS5ocXiYJl/TAF4ls4cC7Pmt
         evmNS8FO/S9AgC5JjIPMbv44ix2R6gHkFP7ZV237EzWIcsRDZCBlU+vc+Yo3Izi8El
         090icYkZbEhSH/JjjC7WnScehq+XOn39XCpf3/WXNu40Ag8iymkR6o1GNLJE7L8sX5
         e+e+FzMMnXL5o0BCyK/5Y2tYizntHRd4HJixnZI+KEOWYgtsy4vFU0xM4QHi1ja5jS
         b4PPXLIE+PEgjZZlmo8sIUEsHRUrSHyVqWapuEZs+ChMj75HgXtqKCaZkiEyThek0/
         cWbEvIxR4zpAw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org,
        mathieu.poirier@linaro.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rpmsg: glink: Add check for kstrdup
Date:   Sat, 15 Jul 2023 15:13:28 -0700
Message-ID: <168945921478.1805013.8443109332257181025.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619030631.12361-1-jiasheng@iscas.ac.cn>
References: <20230619030631.12361-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Mon, 19 Jun 2023 11:06:31 +0800, Jiasheng Jiang wrote:
> Add check for the return value of kstrdup() and return the error
> if it fails in order to avoid NULL pointer dereference.
> 
> 

Applied, thanks!

[1/1] rpmsg: glink: Add check for kstrdup
      commit: b5c9ee8296a3760760c7b5d2e305f91412adc795

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
