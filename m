Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2DB7DFAC3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345278AbjKBTQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjKBTQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:16:21 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6639D185;
        Thu,  2 Nov 2023 12:16:19 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1cc394f4cdfso10455735ad.0;
        Thu, 02 Nov 2023 12:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698952579; x=1699557379;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hi2EMa2JURthjzhOMbj1ijk40LtXcNMKHU4qr6uWg4k=;
        b=XpIE8qS8NGZqosFK74UwSeizioweoMym5CZOAFSU1BZDzrfcysUx9dAPm/jBc+PFTK
         fKNZs+9BtnjCnFkAsiJjzlFAesjJMvYRH5p51mmcBiGM4cA6Vb2tbkQI8t9xmP45JFKr
         BG9a4J61FgZIf4gROcpcI3IF0Ot/qiK0mSOitqFfgZTt01iZaNp4chGT+K0xhtBcKhDo
         SaAOZBiJxXPe1sSJneTvQIrx8hO2Hli2yzccI8Vd5NiX3dN5EvO53geOqWYrBWcVJauN
         2Bsjd9ganw274M+AeFDsZBHkA42gafL6HAlpbpTI0a2qZ9f5ul3/djOegWKcrqHyzipD
         nATg==
X-Gm-Message-State: AOJu0YwoxM6rojURZmfEVxPxoUbB5JpjF1bV4bUGF1pexapOo4eq29kr
        hIqLfuLyxyfcBc8GWvg6l4g=
X-Google-Smtp-Source: AGHT+IGL/Lvym+pJN7/UXiKk8dNV2PsHrB+kPmFxLCSFa0qX8f29Kz0grAvKniaRmcIzpsPEp/4eBA==
X-Received: by 2002:a17:903:32cc:b0:1cc:45d0:46fc with SMTP id i12-20020a17090332cc00b001cc45d046fcmr13519966plr.54.1698952578726;
        Thu, 02 Nov 2023 12:16:18 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:87f7:9784:4475:1cd4? ([2620:15c:211:201:87f7:9784:4475:1cd4])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902744500b001c60ba709b7sm80157plt.125.2023.11.02.12.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 12:16:18 -0700 (PDT)
Message-ID: <45495479-dc4e-4d89-8c0d-836df83ee18a@acm.org>
Date:   Thu, 2 Nov 2023 12:16:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] ufs: core: Expand MCQ queue slot to
 DeviceQueueDepth + 1
Content-Language: en-US
To:     naomi.chu@mediatek.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Can Guo <quic_cang@quicinc.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        casper.li@mediatek.com, powen.kao@mediatek.com,
        alice.chao@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com
References: <20231102052426.12006-1-naomi.chu@mediatek.com>
 <20231102052426.12006-2-naomi.chu@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231102052426.12006-2-naomi.chu@mediatek.com>
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

On 11/1/23 22:24, naomi.chu@mediatek.com wrote:
> The UFSHCI 4.0 specification mandates that there should always be at
> least one empty slot in each queue for distinguishing between full and
> empty states. Enlarge the `hwq->max_entries` to `DeviceQueueDepth +1`
> to allow UFSHCI 4.0 controllers to fully utilize MCQ queue slots.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
