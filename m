Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A177E2B84
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjKFR4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjKFR4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:56:31 -0500
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7670D99;
        Mon,  6 Nov 2023 09:56:29 -0800 (PST)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1cc3c51f830so35102795ad.1;
        Mon, 06 Nov 2023 09:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699293388; x=1699898188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2JiLGU3s2KC5CtuIF/v5v0hrQFMexnAPPTq2XcVAbU=;
        b=faceN5SnOQATyVbwfLk+WX4wCVXmjFqxhsuoCIKkyxI+9ZM9ZGKZUffecTM5GvH4At
         L7uhDBYoTKOsdlKUG+mU7GK+JXpj5FAk4BmhyiTrrHbBxaOOAldA+SkXHg71ysownnNf
         RSjid2286FWOrTV1LSE9nYQMPW0Ezipgf2nBvokOxDbwbrj+rtFHuRdRboiR25Vc5gcR
         SOsdyX/GauTADPjIaMGOYOwrrsxfKTCwyV8STqKy4Dp9+7Z+m60Bh1M6OKX442tazWll
         45tfv/sB309XpxhP3xBOtAZNrEZELA1rdEYCcVBE28FcDrF7jcqQa2ce8bMHhanJVllF
         or8w==
X-Gm-Message-State: AOJu0Ywe+uI6HT0OOvtJcxLHY7T+6xvDsu3ph6IYtInQCnV2ShCDbJD2
        p346ebcoeXAGahAHmwIrzPVUO+goQpA=
X-Google-Smtp-Source: AGHT+IFIwKD7s3sm65uE7HT8rxOzB6AZxTRmE3vQkBIYawoH5/ytsoH4xg0bWJUM7sJt3cSmSdVFAQ==
X-Received: by 2002:a17:902:6803:b0:1c9:ca02:645c with SMTP id h3-20020a170902680300b001c9ca02645cmr20888180plk.36.1699293388064;
        Mon, 06 Nov 2023 09:56:28 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:ac50:9303:758b:edb9? ([2620:0:1000:8411:ac50:9303:758b:edb9])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170903049300b001b86dd825e7sm6191205plb.108.2023.11.06.09.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 09:56:27 -0800 (PST)
Message-ID: <5850d5ac-e735-4358-866d-f410b00ba39d@acm.org>
Date:   Mon, 6 Nov 2023 09:56:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ufs: Add msi-parent for UFS MCQ
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Ziqi Chen <quic_ziqichen@quicinc.com>
Cc:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com, mani@kernel.org,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, quic_nguyenb@quicinc.com,
        quic_nitirawa@quicinc.com, quic_rampraka@quicinc.com,
        linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1698835699-28550-1-git-send-email-quic_ziqichen@quicinc.com>
 <20231106144831.GA317907-robh@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231106144831.GA317907-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 06:48, Rob Herring wrote:
> On Wed, Nov 01, 2023 at 06:48:13PM +0800, Ziqi Chen wrote:
>> The Message Signaled Interrupts (MSI) has been introduced
>> to UFS driver since the MCQ be enabled.
> 
> Not really relevant when a driver supported MSI, but the when the h/w
> did. Has UFS always supported MSI? It was added in some version of the
> spec?

MSI support has been introduced in UFSHCI version 4.0 and I think that
the controller vendor can decide whether or not to implement MSI. Does
this mean that the patch needs to be improved?

Thanks,

Bart.

