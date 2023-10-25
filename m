Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3402E7D609B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 05:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjJYDv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 23:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjJYDvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 23:51:24 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69E9128;
        Tue, 24 Oct 2023 20:51:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c8a1541232so44951095ad.0;
        Tue, 24 Oct 2023 20:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698205882; x=1698810682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UhMIPF+8XCisR3WtupkT8qBfjjJFJcD5nTwARC0s/gs=;
        b=kWc85h+iooFmtQdrlVq0d6DMY69b5O5AjXLrp42ga/ZV295krtopK5kXT/XryEPDOO
         glnoaw0mhAok25Xn6uc/ab2jXmZsv9vOmUcuzuQiTFonC80CvPMss6cIl9j7K5615h7p
         EnzYD/dX1OG86N+nvE84YpX1Wz8kuPFqHOD3xsGqVxrSNVDLPDaYz5fmxOXMcrvyE+0s
         mFAo7OV1M+69K3xnPz/7twe4jiBNt6HOfkyWJgrUfPD71K5MmGMwOqoJ2vCN0tCa6amo
         keG3m2i3l42fRcLKM7GxgF/hmoZxN71h59lsVFrtjk4ineragKvo25Wj+hQ32+ZIvtKg
         RYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698205882; x=1698810682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhMIPF+8XCisR3WtupkT8qBfjjJFJcD5nTwARC0s/gs=;
        b=u+4rIuvC8caFYU8sbCzaUb3OfugY2Q5uZ+Vew6mIyw05QFaDiKuyoWs5mZTMjSYa0z
         fI2DV+bDUS4T5EcRECuA15uNhUEeJCX4ecVR3RDTtD4+//Ww+VNrFzt9Of5zafQOHu5o
         oXirlGDNScxOaexUmB3iQBgi1s+BjSF+dHRQOFlgcsTWFTYGghLEufi7kxL6efUftL0b
         QfUXDNEI6NrpcgwgzA0u2eIS9scUyt4lmVLtexjw9SM5zjlEniLnD+DKyQyUiFKd1z/B
         uXAFiflCdMbxm9VrCelfF/FKiwLPb+9Bu6qLIKAWUSlzDK8M747kn95J1xKnQEQ3cctE
         rZkA==
X-Gm-Message-State: AOJu0YxQWbjPuFzwoHvJReNTwdkMZZiFYTEU5y7N/o9eYzM+vCGm7pnB
        h6nhpyqgoqbDiYxz38pLXIk=
X-Google-Smtp-Source: AGHT+IHK4X3DuO7vvngN4+xx8AKvdNvUIzqilf1531NWaad+TK1T2055o/UnsPCqRaVvPnbwe3F2QA==
X-Received: by 2002:a17:902:eac5:b0:1c6:294c:f89c with SMTP id p5-20020a170902eac500b001c6294cf89cmr12625368pld.63.1698205882171;
        Tue, 24 Oct 2023 20:51:22 -0700 (PDT)
Received: from [192.168.1.13] ([117.243.111.63])
        by smtp.gmail.com with ESMTPSA id z20-20020a170902ee1400b001bdc9daadc9sm8149407plb.89.2023.10.24.20.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 20:51:21 -0700 (PDT)
Message-ID: <e30df89f-6bff-476c-8deb-c0dcadd17950@gmail.com>
Date:   Wed, 25 Oct 2023 09:21:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs/core: ufshcd: Conversion to bool not necessary
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        bvanassche@acm.org
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        stanley.chu@mediatek.com, mani@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, peter.wang@mediatek.com,
        beanhuo@micron.com, quic_nguyenb@quicinc.com,
        Arthur.Simchaev@wdc.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231024183401.48888-1-bragathemanick0908@gmail.com>
 <yq1sf5zctew.fsf@ca-mkp.ca.oracle.com>
Content-Language: en-US
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
In-Reply-To: <yq1sf5zctew.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/10/23 08:14, Martin K. Petersen wrote:
> Bragatheswaran,
>
>> A logical evaluation already results in bool. There is no need for
>> using a ternary operator based evaluation and bool conversion of the
>> outcome.
> Applied to 6.7/scsi-staging, thanks!
>
Thanks Bart Van and Martin!
