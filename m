Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850267D1A1D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjJUAx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjJUAxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:53:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A4CD79;
        Fri, 20 Oct 2023 17:53:15 -0700 (PDT)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5F7836607333;
        Sat, 21 Oct 2023 01:53:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697849594;
        bh=5Orz2yhTKSBrhhOfB2WIhmsf2v0uOKB+2pqKm5j/3JU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aJfsIfki0gasdmaY0NXi9puJQ96LHODU760L57WYm6epYVLsjEtfI64KB0uxZsJMF
         RD+jx7y8Ey4CC/QhTY8sO2q07XFHwjKDG6AV8yy2svt+pZ/Mbc+D4cFbm3dg4Y0hok
         s5kYGnRGe88kj7pSY+G5sYoPo8BnXB7mIKxpK1wPDXrc7iHtbenQn+zTJTwsOnqyir
         44Y536YxcyOvCl5/wL+IyjMhbYnE6ViCAiD6pxvcQRrectJckfmHOfgg8yJJkzSGRp
         ebIViWLJ71GObzHWj1poIWQE8GC1Gn5BgmazynVG/Af73Tkr57Yn5VxpCg6zaVnk6L
         4GIs6dE7CqO5A==
Received: by mercury (Postfix, from userid 1000)
        id 306D0106052F; Sat, 21 Oct 2023 02:53:11 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <20231020-strncpy-drivers-power-supply-bq2515x_charger-c-v1-1-46664c6edf78@google.com>
References: <20231020-strncpy-drivers-power-supply-bq2515x_charger-c-v1-1-46664c6edf78@google.com>
Subject: Re: [PATCH] power: supply: bq2515x: replace deprecated strncpy
 with strscpy
Message-Id: <169784959118.1512524.15084907923793161018.b4-ty@collabora.com>
Date:   Sat, 21 Oct 2023 02:53:11 +0200
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


On Fri, 20 Oct 2023 18:59:34 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect bq2515x->model_name to be NUL-terminated based on its usage with
> sysfs_emit and format strings:
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq2515x: replace deprecated strncpy with strscpy
      commit: e3c2af5d49bb96ad460ef6aa873975fb0f7c7f17

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

