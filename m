Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6EA7C5EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376315AbjJKU4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjJKU4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:56:52 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A80B90;
        Wed, 11 Oct 2023 13:56:50 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-27cfb8bc7eeso186196a91.0;
        Wed, 11 Oct 2023 13:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697057810; x=1697662610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fCHObAEeL5mzpUTwwILbHdlQXAib9rb/QiAV6nbo0Q=;
        b=RFGP8ZzMUT9BNA8FtKED82EWcTDI7LvmUqIiA42CrFIBBXYgABZe+dDEhSzeRSHf0i
         sIcNHssiLBMgx28X0gAT9PFX4jxJrYPtDqcVQ3JEnsjlC7kVP0uxhzi72MBodXVqGHmx
         GeGVwKD+mnIWF2FANMey+78smV3j3Dd5igEalzTSKqfoAIMvudsG6Y1u+Omd5CLA5EjC
         3tAuT+Xv1t2QFy8lslJFjWs27qJuFNqVRaea3J0DZWrvJGrsOsBz2+niS5NXJKPIqLP7
         KkoPeVa/PUMxPr4tOmQ+MsMlDRlHU2Drd8gYU1OzDqhX1qAEYrvMhAtRkcFRaaSwXv/P
         AkWQ==
X-Gm-Message-State: AOJu0Yy2iozfPYVkKiExzLH+BJzDLKhzTEmHZovWjW+v+wj9jWPQdH3I
        X84EfqnkjgUC1DFvKQfv404=
X-Google-Smtp-Source: AGHT+IG71j0EgRlck26WH3mT2067Yv5guihfeH1VtvMnSfj7MCMwdvHpRv3xWbysKOyNPt8XJoWarw==
X-Received: by 2002:a17:90a:1650:b0:27d:273:93ba with SMTP id x16-20020a17090a165000b0027d027393bamr3045155pje.30.1697057809787;
        Wed, 11 Oct 2023 13:56:49 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:19de:6b54:16fe:c022? ([2620:15c:211:201:19de:6b54:16fe:c022])
        by smtp.gmail.com with ESMTPSA id d17-20020a17090ac25100b0026b70d2a8a2sm353153pjx.29.2023.10.11.13.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 13:56:49 -0700 (PDT)
Message-ID: <23c91551-9d94-4ec6-85eb-be1e2af20dc7@acm.org>
Date:   Wed, 11 Oct 2023 13:56:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 0/4] Add per-cpu PM QoS support for QCOM UFS
Content-Language: en-US
To:     Maramaina Naresh <quic_mnaresh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com
References: <1696952947-18062-1-git-send-email-quic_mnaresh@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1696952947-18062-1-git-send-email-quic_mnaresh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 08:49, Maramaina Naresh wrote:
> Add per-cpu PM QoS support for ufs. This improves random io performance
> by 20% for ufs.

What in this patch series (other than the DT-bindings) is specific to
the Qualcomm driver? If the answer is not much: please move this
functionality into the UFS driver core.

Thanks,

Bart.

