Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EBB7B438B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 22:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjI3U2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 16:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjI3U2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 16:28:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93E7DD;
        Sat, 30 Sep 2023 13:28:28 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9AF316607285;
        Sat, 30 Sep 2023 21:28:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696105707;
        bh=vlw+MU72LdeuMNv4Xr4xD9ANXCuO7W9In6kKp8wW2+8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lACjukiV3Y01SqBP4euzWvY+HG0tbEAkZxBjR2C6xQB+69F4wY0uutYgFHQTWVFjk
         weW5ehZlEQPA00ZEdUzBXi+Tq8QU045Emjs3dyu8t2PE0e55344F/z++pnDN/f3O3n
         mAIbwsGBpam506y8ZgFUhl5IXO57VYp4dV8nCGF+KQtZeEroqvBK7U37hAu2iyix0T
         1HP+ksVaylcvpnEJqeVxdNo6jyLTYqKIpPBFbXrmvi4SBlOn7Qmuk3oBqs2F9Kv4n5
         XA8vPmFDVEiCWIzlHWknNdFn80WYDeUJ8nmS+h+4P4JBwHYYprrTG9zQZJWuoKH/mX
         tPF7NBBHcqrbg==
Received: by mercury (Postfix, from userid 1000)
        id A9BC310603F9; Sat, 30 Sep 2023 22:28:25 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20230919124222.1155894-1-sebastian.reichel@collabora.com>
References: <20230919124222.1155894-1-sebastian.reichel@collabora.com>
Subject: Re: [PATCH] power: supply: qcom_battmgr: fix battery_id type
Message-Id: <169610570565.215050.3005870455155927918.b4-ty@collabora.com>
Date:   Sat, 30 Sep 2023 22:28:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 19 Sep 2023 14:42:22 +0200, Sebastian Reichel wrote:
> qcom_battmgr_update_request.battery_id is written to using cpu_to_le32()
> and should be of type __le32, just like all other 32bit integer requests
> for qcom_battmgr.
> 
> 

Applied, thanks!

[1/1] power: supply: qcom_battmgr: fix battery_id type
      commit: 383eba9f9a7f4cd639d367ea5daa6df2be392c54

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

