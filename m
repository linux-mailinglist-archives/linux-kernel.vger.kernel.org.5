Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3207A6EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjISXES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjISXD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:03:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475CB122;
        Tue, 19 Sep 2023 16:03:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921E5C4339A;
        Tue, 19 Sep 2023 23:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695164630;
        bh=Fkuj2wWZmMnPShQV/ULhqGln8Ca5xiurzcw3wVvpsGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4QmMc9SBynpqOTarnupu5xaA4eHNG/4uPm/vu2d7GbqG1uqiJkF4FcsCMScJLhME
         dJynJvO7J5fCGyRF1u5WbvVsfUxhCla1FOhJuS0RNf4utFMbh4z5HVNYFRou+tGAHJ
         A6F2bRa7eF0VT2N29mxpPmby2KXp0WwGXwCy8MXCLRfznf2rTkhOTUV8KdmVTetF/y
         6SRgoinWnf6QNSYOh8Y48tEfkfUJ/gApVFIcwetQqNrxqMQl5TJuIITXFCqDdX2OPK
         vgkyxlmM65zvt5BMkoA2Gtdei4Ys5XEE1PA/n86TADR8TzX61oZ5fbEp8+HcqyAymN
         IpJiZRIyfG4xw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Hongfei <luhongfei@vivo.com>
Cc:     opensource.kernel@vivo.com
Subject: Re: [PATCH v3] soc: qcom: pmic: Fix resource leaks in a device_for_each_child_node() loop
Date:   Tue, 19 Sep 2023 16:07:39 -0700
Message-ID: <169516485977.787935.14775411918002556697.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230612133452.47315-1-luhongfei@vivo.com>
References: <20230612133452.47315-1-luhongfei@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Jun 2023 21:34:52 +0800, Lu Hongfei wrote:
> The device_for_each_child_node loop should call fwnode_handle_put()
> before return in some error cases, which could avoid resource leaks.
> 
> Let's fix this bug in pmic_glink_altmode_probe.
> 
> 

Applied, thanks!

[1/1] soc: qcom: pmic: Fix resource leaks in a device_for_each_child_node() loop
      commit: 5692aeea5bcb9331e956628c3bc8fc9afcc9765d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
