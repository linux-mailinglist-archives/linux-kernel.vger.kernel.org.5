Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5877A099C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241192AbjINPrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241065AbjINPrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:47:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D4ED7;
        Thu, 14 Sep 2023 08:47:20 -0700 (PDT)
Received: from mercury (dyndsl-091-248-132-131.ewe-ip-backbone.de [91.248.132.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0751A660727E;
        Thu, 14 Sep 2023 16:47:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694706439;
        bh=BFXg+eiGm56PIuoHY4sJWN6imZT6VBrEHcdIVjqZMV8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fMjGX392d+eycmU1JptKG5B6QxJoOfylTA4Minb45ZgdSn5XxyC86vUQatfMAvhx8
         QTmxuiF70gxHDetoTOWv0C3CQGizkLJ/xFNv9nD5aY8Vc5zUBK4QqbxDL7LlhcT5yR
         eHScGpGQo9F/g5mKA2nXseVddd8szH0AQXIQH8hJBNoyJiShmC/Qp1LH+59lrTtZo5
         k+NJJSctEfis1fvXwyEnlgwzZt6NVWGI71ld6SpJK0rGGf4ppPVrXfAcaBWnbVL2od
         7X/ZTCseZs08RlAxcSb8BQWt8A+jJwr7hroCqzG6SWJL4kryQfYwaZW/iCZSIwJ+8m
         1TQlc6FA6njMw==
Received: by mercury (Postfix, from userid 1000)
        id AB7E8106098B; Thu, 14 Sep 2023 17:47:16 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Maximilian Weigand <mweigand2017@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Maximilian Weigand <mweigand@mweigand.net>
In-Reply-To: <20230601-rk817_query_at_resume-v1-1-630b0adefbd9@mweigand.net>
References: <20230601-rk817_query_at_resume-v1-1-630b0adefbd9@mweigand.net>
Subject: Re: [PATCH] power: supply: rk817: query battery properties right
 after resume
Message-Id: <169470643667.728745.9541919851740286656.b4-ty@collabora.com>
Date:   Thu, 14 Sep 2023 17:47:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Jun 2023 20:10:43 +0200, Maximilian Weigand wrote:
> The driver reads battery properties every 8 seconds. In order to prevent
> problems with wrong property values right after resume, trigger an
> update of those properties on resuming the system and restart the
> 8-second interval from there.
> 
> 

Applied, thanks!

[1/1] power: supply: rk817: query battery properties right after resume
      commit: 1769142a14c34a8acd67657bc3e637f22f75e026

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

