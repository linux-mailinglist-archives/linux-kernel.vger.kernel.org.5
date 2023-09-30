Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC4A7B438D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 22:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjI3U2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 16:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjI3U2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 16:28:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9783F9;
        Sat, 30 Sep 2023 13:28:28 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A09F16607295;
        Sat, 30 Sep 2023 21:28:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696105707;
        bh=5H7NbrsgqULN82SuDa6zSGealrTVrOF+2Ikbmj0ec6U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jJYWVNPkUmKZ2usi5PEOqnrSdjkJB6ZmaU+jEsvH0zV09bN6sO30gcON49Y7sQ4VI
         ND+czJgr02BKj6bX4RWFC7GTyY3n3jw1JEnHXpvXjWmBFWqP8+UfIkmsYPA1hQut/N
         nTBlwBwPrNNgObz/Y4s1p9V73SJ5OKj7G3vBE7loDf8CohHpyPBwXFmy6rK+3LRLLI
         kmBeKhpldjglQ/kDdmxiTzOv9OUCeljMIORdnxoAXNURJQf25gqGA8eed4RAX53sIz
         To9TXAsg2ZIGATPFGuxlusSP6b4ZGY8w8apDUd9izWos8L6Gi0apGsodoN3ASy+BmI
         eXgjjXqJdGpgQ==
Received: by mercury (Postfix, from userid 1000)
        id AE0C210605D7; Sat, 30 Sep 2023 22:28:25 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20230929101649.20206-1-johan+linaro@kernel.org>
References: <20230929101649.20206-1-johan+linaro@kernel.org>
Subject: Re: [PATCH] power: supply: qcom_battmgr: fix enable request
 endianness
Message-Id: <169610570570.215050.7442025506091281047.b4-ty@collabora.com>
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


On Fri, 29 Sep 2023 12:16:49 +0200, Johan Hovold wrote:
> Add the missing endianness conversion when sending the enable request so
> that the driver will work also on a hypothetical big-endian machine.
> 
> This issue was reported by sparse.
> 
> 

Applied, thanks!

[1/1] power: supply: qcom_battmgr: fix enable request endianness
      commit: 8894b432548851f705f72ff135d3dcbd442a18d1

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

