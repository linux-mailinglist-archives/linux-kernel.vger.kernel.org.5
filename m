Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADBE78B140
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjH1NA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjH1M7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:59:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABDD126;
        Mon, 28 Aug 2023 05:59:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77D6363A73;
        Mon, 28 Aug 2023 12:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2D5C433C8;
        Mon, 28 Aug 2023 12:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693227590;
        bh=UWDYrB+OaFsKrZ4prIKM9qiS9QoBdhDptwEyds6RsBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NlYjenbhMOadwbG6IQ8/yxoAXRKMTlZBeWOqCzDudhuHdmqFm6TSrix8lzt8Gk1dY
         8KU9wHNTaqBuxZEaoCJUFpmlSqevjIuHJ8FOwHF+D81XQ0hIZfEAgSlGaHZ/oE8FgF
         +g3zXGbLRPArUplYKArXA6twkHoAvL946Zy7ZM6uQSFxxJeNTxNZFMjBr36pimJCPm
         7/bX1fRCAp9gSAGeUbHSrErfh8iy0/O4uGCXTKMdvnBJUD3433NLmNQhdECa1dzyYJ
         9bEq0X+6vsu0+Lo/B/H1wTRagUqYKAOYvZOVVXPPRrJz4hg8nsmXCPVJiZkefJ5DnD
         qORdGmTSuH6ZQ==
Date:   Mon, 28 Aug 2023 18:29:35 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Nitin Rawat <quic_nitirawa@quicinc.com>, mani@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        jejb@linux.ibm.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V5 0/6] scsi: ufs: qcom: Align programming sequence as
 per HW spec
Message-ID: <20230828125935.GJ5148@thinkpad>
References: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
 <yq1h6omztl3.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq1h6omztl3.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 05:44:01PM -0400, Martin K. Petersen wrote:
> 
> Nitin,
> 
> > This patch aligns programming sequence as per Qualcomm UFS hardware
> > specification.
> 
> Which tree is this against? Doesn't apply to 6.6/scsi-queue...
> 

Martin, thanks for considering this series. However, I'd request you to wait for
an Ack from atleast one reviewer/maintainer before merging the Qcom patches.
Reviews might be delayed, but for sure we are keeping an eye on all patches.

- Mani

> -- 
> Martin K. Petersen	Oracle Linux Engineering

-- 
மணிவண்ணன் சதாசிவம்
