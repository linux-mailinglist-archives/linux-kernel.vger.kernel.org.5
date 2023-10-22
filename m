Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D1B7D2470
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjJVQWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjJVQVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:21:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA5B188;
        Sun, 22 Oct 2023 09:21:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22584C433CA;
        Sun, 22 Oct 2023 16:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697991690;
        bh=nbDc5cjQUnF9X99btn9OHL2gzyTJ84ZS3/J4fySDlmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NydAZHVspub/Jbmr5pimoNdQ2v84pj04Xs5m17M2ft5IX9WLJzd/0fhJHa4qF/14t
         0DNGHE5RPLfTFXRg+MIAPVxH0OK9OlDJSfonlvwUd8JAYfUiXzRF4a6lgFRyQwx48P
         mA3tCt6oGSg/gIQckpyv7KSIGZp21oumrUvJGoM6vLndL1XOe/zc6XVZxqvp1upkF9
         QFBJqcNPzz6M5OXfdy08z5yqZVVC9uzigYwLjzIfiSEtjnF3uef6TfcLghH1PrmFjj
         pM+JtLWkyYeLO5lwZeCOXYQotuJwK85rqonWnJTrJdkpAcCLbVSaEcPgbXM5RSrlCO
         Nxn+nscE1IxwQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] soc: qcom: pmic_glink_altmode: Print return value on error
Date:   Sun, 22 Oct 2023 09:25:51 -0700
Message-ID: <169799194925.679418.4138128502032758267.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017-glink-altmode-ret-v2-1-921aa7cfc381@fairphone.com>
References: <20231017-glink-altmode-ret-v2-1-921aa7cfc381@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Oct 2023 10:00:23 +0200, Luca Weiss wrote:
> It can be useful to know with which return value for example the
> typec_retimer_set call failed, so include this info in the dev_err
> prints.
> 
> 

Applied, thanks!

[1/1] soc: qcom: pmic_glink_altmode: Print return value on error
      commit: 723d346173e748c4fdb145b84f572b871ab4011a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
