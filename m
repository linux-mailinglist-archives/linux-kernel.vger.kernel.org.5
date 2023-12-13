Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079C7811868
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442351AbjLMPxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442173AbjLMPxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:53:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F182AC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:53:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1C8C433C8;
        Wed, 13 Dec 2023 15:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702482835;
        bh=jRw2iQ+rJIACWDizkXDvyIApifMCkj/Xxp2gkDAX/zo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WEsEOsEzONZAKzmGNB7hGWru8gtPCyie5L2vsLXPuIFJHL/4xez4mej3rLgiNMoIe
         iXWBZ+TDayj1fg5uD4cTD4nGrDgHbUizKFjcQNZO7P/2NntVTCGtcFHGpf7yN4qSgL
         cFqkaOKbadtDQ00uI704MTyuEGO8rk3B87DARMSmTAaZJgskQEB30BhK/v7CWFcvc/
         vhtn3To65SazKHEdc/i3kTeIfNStfCW96eqmMZr5ChRKpMzguUl5Xp9Dw3Mjp++lKJ
         kG2JNJbxQbTrj3aMET9u8vM73A5buzOfZwPqq8mHVe/ri2DbbsLEg+OvlecBpzotbt
         /j3xU2vPKweag==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, jpanis@baylibre.com,
        Kunwu Chan <chentao@kylinos.cn>
Cc:     kunwu.chan@hotmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20231208033320.49345-1-chentao@kylinos.cn>
References: <20231208033320.49345-1-chentao@kylinos.cn>
Subject: Re: (subset) [PATCH v2] mfd: tps6594: Add null pointer check to
 tps6594_device_init
Message-Id: <170248283388.995399.4120913021603641988.b4-ty@kernel.org>
Date:   Wed, 13 Dec 2023 15:53:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2023 11:33:20 +0800, Kunwu Chan wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> 

Applied, thanks!

[1/1] mfd: tps6594: Add null pointer check to tps6594_device_init
      commit: 825906f2ebe83977d747d8bce61675dddd72485d

--
Lee Jones [李琼斯]

