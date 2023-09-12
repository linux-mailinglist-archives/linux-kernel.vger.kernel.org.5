Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A3A79D86E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbjILSKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjILSKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:10:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0581115;
        Tue, 12 Sep 2023 11:10:49 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 762E26607314;
        Tue, 12 Sep 2023 19:10:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694542248;
        bh=FhDLFq9cvyIVyCheEG4JH6P47GD8kKDfClOTq6CXyj4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HI/tPnbirevBuH6jxTBDGDREvGFxZ0mTHmv4/6lph91IrtQ/yOyo3DSFNpZATBdBE
         qdeOVcKv8VDDls0VgFmoF46D0eUQ50XPWbz7Qav1pkKzwrIbjiPlTJyWnzpOT43Bgg
         wFFG8w5xnisroI5O4vF/XNeI2/9G30NWSavwVP6S5j0XS+JrVUE8DUDM5MbzSrRg6Z
         XWPFVD8spUyeffoczi6fPF5SGWfhlgPH510lcijaAP1SEaUiwQJrBkBwuJh+z26yig
         vh8pS8/wYYqFDk0pOI9AOmqmdhyP0lALj+hcTrMs8oIh/4Dfdn7eoygi6MG0BSZimw
         QTydmmJQFcX1Q==
Received: by mercury (Postfix, from userid 1000)
        id 3D0FF106098A; Tue, 12 Sep 2023 20:10:45 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     sre@kernel.org, David Thompson <davthompson@nvidia.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        asmaa@nvidia.com
In-Reply-To: <20230823133743.31275-1-davthompson@nvidia.com>
References: <20230823133743.31275-1-davthompson@nvidia.com>
Subject: Re: [PATCH v1] pwr-mlxbf: extend Kconfig to include gpio-mlxbf3
 dependency
Message-Id: <169454224519.477931.4702289950559455440.b4-ty@collabora.com>
Date:   Tue, 12 Sep 2023 20:10:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Aug 2023 09:37:43 -0400, David Thompson wrote:
> The BlueField power handling driver (pwr-mlxbf.c) provides
> functionality for both BlueField-2 and BlueField-3 based
> platforms.  This driver also depends on the SoC-specific
> BlueField GPIO driver, whether gpio-mlxbf2 or gpio-mlxbf3.
> This patch extends the Kconfig definition to include the
> dependency on the gpio-mlxbf3 driver, if applicable.
> 
> [...]

Applied, thanks!

[1/1] pwr-mlxbf: extend Kconfig to include gpio-mlxbf3 dependency
      commit: 82f07f1acf417b81e793145c167dd5e156024de4

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

