Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9574477230A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjHGLud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjHGLub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:50:31 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D21499
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 04:50:30 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bbc64f9a91so38272995ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 04:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691409029; x=1692013829;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DUiazTj+VYmFEy955EKtxmP3ocpz0QHylcvEbnBUq/k=;
        b=tL85YccuskFEAnglasCTymvzAvH0LOxoM1WtfMclwFxD5v4NAy2D4sNQhhQ/pu1Lko
         Me80FobM+DbAP5RVrWrbj0iXC79ccdLGV2seN2v4OjF9siDks3jCMR1D+IpLDcineBIh
         qET1XGb9sPiRpoPav6sxxJmqa0Mt8WCyo797sh4DBFwMC8cQzNO03+g7vO1sNmzBGLib
         sOIRMMMr5znMKn6gX++zsaSJNlvPS+mRwShY5qoekEKGzosRO2A9UgPqO9wEbRDcWQPS
         ZoGsAePYW7wfjwdmeSpck6lSACtr0iM3W6k0TQMAbOymijaEjmopVOaHq5DieJAZsqsB
         Pz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691409029; x=1692013829;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUiazTj+VYmFEy955EKtxmP3ocpz0QHylcvEbnBUq/k=;
        b=aEDalpDTcgtG6C+dm9P9uKxQ5TcsPUQgJfsDUCetKp9t2iYXpvvN0RKUoazwAGgs10
         WD5uxc3SCaSAtg2ybQsXeMgk96DyOCBPP7pMM5yYZ4AgPsDu19jqc6iqeEyqiqgPqLcg
         6YQ6hQblvt/TYSHktajVfqu4i3mcbzO4YGyXkqBx/xPzO3ZP9Ixw7y6LC0/yMJM4xuZz
         PYBf1QZDFojwbxlxxSuvU8m31TGPymRBlcy3T+dnKAQmH1JPAjh9Ysttv77fkkTXU914
         bG0GRothR3WKS4sx/XXkb3FmKIEoiwpT/steK92l+dlmoBm6YXGk9kAW6Dnq5MNtCOPd
         rZOA==
X-Gm-Message-State: AOJu0YyhPjRxeKyzqjxKHMJ0xZE+gq0QnG1u0x/kEAxQFyFLL5l2rzWs
        THT18RPgk+/ncuCVULL5eqlN
X-Google-Smtp-Source: AGHT+IGxyG24eMZv/l2Boj+w3NLo3TG8tCkd7qIJbJJtJvwpjYmapCBxD30NmTuiSRERTPfZu2DVRA==
X-Received: by 2002:a17:902:b68c:b0:1bc:2036:5338 with SMTP id c12-20020a170902b68c00b001bc20365338mr7850977pls.28.1691409029383;
        Mon, 07 Aug 2023 04:50:29 -0700 (PDT)
Received: from thinkpad ([117.217.180.167])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b001b8a1a25e6asm6706018pll.128.2023.08.07.04.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:50:28 -0700 (PDT)
Date:   Mon, 7 Aug 2023 17:20:21 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>, quic_mdalam@quicinc.com
Cc:     vigneshr@ti.com, richard@nod.at, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com, dan.carpenter@linaro.org
Subject: Re: [PATCH 00/10] mtd: rawnand: qcom: Bunch of fixes and cleanups
Message-ID: <20230807115021.GB18257@thinkpad>
References: <20230805174146.57006-1-manivannan.sadhasivam@linaro.org>
 <20230806155309.25427927@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230806155309.25427927@xps-13>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2023 at 03:53:09PM +0200, Miquel Raynal wrote:
> Hi Manivannan,
> 
> manivannan.sadhasivam@linaro.org wrote on Sat,  5 Aug 2023 23:11:36
> +0530:
> 
> > Hi Miquel,
> > 
> > This series has fixes for the smatch warnings reported by Kbuild bot [1]
> > and also several cleanup patches based on my code observation.
> > 
> > I've only compile tested this series. So let's wait for Sadre/Sricharan to
> > give a tested-by tag to make sure I didn't mess up anything.
> 
> I reviewed all the patches, they look good to me. I'm waiting for the
> tests. Please provide the output of nandbiterrs -i.
> 

I tested the series on Qcom SDX55 based dev board, but it was broken already due
to commit <3fc92384b654> ("mtd: rawnand: qcom: Implement exec_op()").

I'm seeing a string of this error while the partitions were being enumerated:
qcom-nandc 1b30000.nand-controller: failed to copy last codeword

It just goes on...

Sadre, on what platform did you test 3fc92384b654? From a quick look, the BAM
DMA transactions are timing out.

- Mani

> Thanks,
> Miquèl

-- 
மணிவண்ணன் சதாசிவம்
