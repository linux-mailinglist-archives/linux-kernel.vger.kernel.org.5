Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EFF76EFB0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbjHCQfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbjHCQfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:35:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CA930D2;
        Thu,  3 Aug 2023 09:35:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC5FC61E37;
        Thu,  3 Aug 2023 16:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BF9C433CC;
        Thu,  3 Aug 2023 16:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691080517;
        bh=ZTZgeCCqcCk5qt3bqo0mNlPdVNRWhr4NJIvWHGkwC7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dv9/S6UCgzugrr5kPIj6znHz+y8Os2gQPoLd8ZeUNNwQghH91gAp+49PEiQkUrh/V
         RLu4q35WGpN5kTIcvdM/Hge7K5OLoqTTaHL1pDgMXX/N3TEMnpQw0BqwD1/h0tVNmk
         1DCN2OMmGDTGNyP25xINCLwMzcWR0pdFi2wpi+OCIKr6I3q0E1d41qru7J3dlol5kW
         oCyZi5g8XkyB1J11lG1oFWIxg/c8bAYLHqteQWMCNsfaTj0SXkO4+I7iISC4Ae07io
         9zKP1ON7B0JZaenfd7MOL9W3OuL/M3o+5cOaOzi2iNYXpBqQP51csTngk44E/GqgRV
         Yfa1ykcjNEuXg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Cc:     quic_varada@quicinc.com, quic_clew@quicinc.com
Subject: Re: [PATCH v3] soc: qcom: qmi_encdec: Restrict string length in decode
Date:   Thu,  3 Aug 2023 09:38:07 -0700
Message-ID: <169108064636.108343.3377347407906942880.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801064712.3590128-1-quic_ipkumar@quicinc.com>
References: <20230801064712.3590128-1-quic_ipkumar@quicinc.com>
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


On Tue, 01 Aug 2023 12:17:12 +0530, Praveenkumar I wrote:
> The QMI TLV value for strings in a lot of qmi element info structures
> account for null terminated strings with MAX_LEN + 1. If a string is
> actually MAX_LEN + 1 length, this will cause an out of bounds access
> when the NULL character is appended in decoding.
> 
> 

Applied, thanks!

[1/1] soc: qcom: qmi_encdec: Restrict string length in decode
      commit: 8d207400fd6b79c92aeb2f33bb79f62dff904ea2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
