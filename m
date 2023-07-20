Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3D575B4CB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjGTQoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjGTQoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:44:44 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BD2E43;
        Thu, 20 Jul 2023 09:44:42 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-262f7b67da8so540259a91.0;
        Thu, 20 Jul 2023 09:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689871482; x=1690476282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctqaYU09ArSRwQw32H48XIaLjIzfILrKXlWnxf+Rzg8=;
        b=LVmm2XiDs7ekH/orM9CiULtttCWH04AO3FF1rlPXHaOfp30d9gnaWrRMnT29UIu9Gb
         rrJ+VYVUXAsyXep8VmobnFpvytPKkeD1EYdygbZzeBLUz0lrd1G/ukciS6sPxkRzu0cv
         hNCXKZVzm+vxaLR96O0EOaj92ZsAJcGyfcZePoPFXlTxm3A5LPXoB8hfNFYlr/zoquOF
         expOd9zIKzAIpaqusnSFuHCcmDBv1veYRXobppBZCfAUwpNcUT3JWvvTxVtM/HBSyjgc
         aNDDM6e4+ZZLLDS0cxPjTQdmNTSQoTmjK89Ly4hiDW5iq3v0DHpoRf81lDvSSO0gL1w8
         BB7w==
X-Gm-Message-State: ABy/qLbUrC4n0hWYxQwhEr0UpKbSp803jV54Wf3N82jpDwOSa7HHYIJd
        SV/Ed0S9rcxY2rf5woDTbRNf3gsitjK0IQ==
X-Google-Smtp-Source: APBJJlHgtgbpjNMR0O6O6wWRcFlkIp0IcCyDcaCcC2tZFJGOAcGugdM7LWjtbzfr/AjZ++6ILh/EQA==
X-Received: by 2002:a17:90b:4f84:b0:263:5c78:4b63 with SMTP id qe4-20020a17090b4f8400b002635c784b63mr2131882pjb.45.1689871482028;
        Thu, 20 Jul 2023 09:44:42 -0700 (PDT)
Received: from ?IPV6:2601:642:4c05:946:30b8:ec2e:fe9b:4835? ([2601:642:4c05:946:30b8:ec2e:fe9b:4835])
        by smtp.gmail.com with ESMTPSA id h13-20020a17090a648d00b00259e553f59bsm2912247pjj.20.2023.07.20.09.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 09:44:41 -0700 (PDT)
Message-ID: <e46f077f-4602-1882-bc14-e8df2a216773@acm.org>
Date:   Thu, 20 Jul 2023 09:44:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 00/15] UFS: Add OPP and interconnect support
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org
References: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 22:40, Manivannan Sadhasivam wrote:
> This series adds OPP (Operating Points) support to UFSHCD driver and
> interconnect support to Qcom UFS driver.
> 
> Motivation behind adding OPP support is to scale both clocks as well as
> regulators/performance state dynamically. Currently, UFSHCD just scales
> clock frequency during runtime with the help of "freq-table-hz" property
> defined in devicetree. With the addition of OPP tables in devicetree (as
> done for Qcom SDM845 and SM8250 SoCs in this series) UFSHCD can now scale
> both clocks and performance state of power domain which helps in power
> saving.
> 
> For the addition of OPP support to UFSHCD, there are changes required to
> the OPP framework and devfreq drivers which are also added in this series.
> 
> Finally, interconnect support is added to Qcom UFS driver for scaling the
> interconnect path dynamically. This is required to avoid boot crash in
> recent SoCs and also to save power during runtime. More information is
> available in patch 13/13.

How much power can OPP save? I'm asking this since I'm wondering whether
the power saved by OPP outweighs the complexity added by this patch series.

Thanks,

Bart.
