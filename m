Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB14C753149
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbjGNFbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjGNFaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:30:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F90130E9;
        Thu, 13 Jul 2023 22:30:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B99DA61BD1;
        Fri, 14 Jul 2023 05:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6060EC433C9;
        Fri, 14 Jul 2023 05:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689312649;
        bh=/P16UMS9w+gPDKvUo85lvvS3dVy7TakBJ97A2f569f0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JoLMfBWUKVbDvjyKZjUpA3nQL7EUB/lsFrlCUM8FxA9DVeyZ4s2zRcXO1McxKKxte
         SgGXiv2bRUfBDaZhvSG3CwRMwxamSa4YC9aidIUE27Zohx8IIaZBah1RJ9NwLzNfHb
         xQv52kj4ll6/rNko1frr7T8tQPhSSbryzI3tnE7LG0sDnTeydjSrUAPZ6akPcB1Xi7
         qs65CQDKJW39cqdRlKIKPA5vXdD27owtku5MkxdRLV4S2RiPb55QNGRFWv4q6B722n
         irKVoRQmW3N391Cm0n100DBrhljh1FvCnc/V+17vON2cZcdCg73jcmyIBsxuafBkiX
         aVK38nSZ9wozA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_nitirawa@quicinc.com, agross@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64: dts: qcom: sa8775p-ride: Update L4C parameters
Date:   Thu, 13 Jul 2023 22:34:04 -0700
Message-ID: <168931284123.1538684.5288002583607457968.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711105915.30581-1-quic_narepall@quicinc.com>
References: <20230711105915.30581-1-quic_narepall@quicinc.com>
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


On Tue, 11 Jul 2023 16:29:14 +0530, Naveen Kumar Goud Arepalli wrote:
> L4c is the supply for UFS vccq, As per UFS spec range of vccq is
> 1.14V to 1.26V, There are stability issues when operating at
> marginal voltage. Hence configure the min and max vccq voltages
> to 1.2V.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sa8775p-ride: Update L4C parameters
      commit: e608d16e01456f82738bd98f6f5ca9f46634369d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
