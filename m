Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E716980A62C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574215AbjLHOwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574081AbjLHOvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:51:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188271997
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E26C4339A;
        Fri,  8 Dec 2023 14:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047082;
        bh=ezbXukdznbtF2XxfnidaejPJUCFYZ2riEOg86Xf13xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I05Ob8SQrW2PPukaGFgdb6zTlKSGUWUXDFDnBy0xMVb2h6mAx/72J+yUhPLN91aPd
         lNn4vI/ltgK9UcFMa1l5jxty1YTC2cIij79/3OhPnsWYiGtVworXL2dv/XLK8fXzTL
         Bvv4CEOX2f4oB8lgnjUCSPpSxPk9xWDF7meGRxoCM/T/aaS+xJtbuokI50zfkBhbfJ
         7kAk6FhC2bPJv2l4KdJFaKzuARfO1FXz6eoJmapAZ1jIcRfIs6IuO68nTzF/b0t9dd
         zBC4T1Bwj+ykhPBD2fp7+nApTV3ASWrFXyraEN2/sHNzEA3jvNfNaMoI8nnY/xZFif
         RtNnz0+ybFj+g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] soc: qcom: stats: Express AOSS QMP module dependency
Date:   Fri,  8 Dec 2023 06:55:31 -0800
Message-ID: <170204733605.342318.6755050556623880114.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231205-qcom_stats-aoss_qmp-dependency-v1-1-8dabe1b5c32a@quicinc.com>
References: <20231205-qcom_stats-aoss_qmp-dependency-v1-1-8dabe1b5c32a@quicinc.com>
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


On Tue, 05 Dec 2023 20:38:40 -0800, Bjorn Andersson wrote:
> In the case that the Qualcomm Sleep stats driver is builtin and the AOSS
> QMP driver is built as a module, neither the implementation nor the stub
> functions are available during linking, resulting in the following
> errors:
> 
>   qcom_stats.c:(.text+0x33c): undefined reference to `qmp_send'
>   qcom_stats.c:(.text+0x8a0): undefined reference to `qmp_get'
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: stats: Express AOSS QMP module dependency
      commit: 70b139a7af7106b59ca5ca77673a9c56982b3089

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
