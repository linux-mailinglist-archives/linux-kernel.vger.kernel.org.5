Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC25B7D5B02
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344160AbjJXS7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343856AbjJXS7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:59:43 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8C710C3;
        Tue, 24 Oct 2023 11:59:39 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ac88d2cfaaso3777552a12.2;
        Tue, 24 Oct 2023 11:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698173979; x=1698778779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqdTgJU7OJSh2UIoWNVVxddyfkvt/XLDbL6ku1eOseU=;
        b=kwYcU3rEeZD21aWf3yocgmRprNXfsUDfjCplZfkxvWlrJOrpR4pBq8boDtFW+CBtkH
         IV0OBO+tYDJNhd7+FBIzZ8b8zKQCSYpuwXK/djGCba5sxZaOncxqxTaemVKG4kZjndCu
         JZ0uXx7Tv0f0QyrXVUBteAIi+2++Rhmb18wGyIIJ1CEvxf9VZlGfQ3nHTpC+kjf1OjME
         P+NoRZ+Dki85kxAagHUclepYDQQBhpZO95Msjrlun7M2KeGmUaLAFo6GP3rZAgk8pBmq
         FOsTuLljmHNPZ1l/ije9pOy1DnAZXugQcdvL/UfQi1DgluSioDyB6TZBq59NgnpSszll
         ECDA==
X-Gm-Message-State: AOJu0YxbhoVWDWBeYrLl8pZG4vWi0CnkLYfKEcMz4uAbWv/F8NvpOBRg
        vH3xZN9QEXvH/Z2Lv8ovA08=
X-Google-Smtp-Source: AGHT+IEdoPWiqS42glVljjUXLVDmycd2pUC+/P3hGE/zwYhUPRXebdv5SQoqHLjEwi0Rrg5FBc0PLg==
X-Received: by 2002:a17:90a:1993:b0:279:354b:50f1 with SMTP id 19-20020a17090a199300b00279354b50f1mr11617386pji.3.1698173979146;
        Tue, 24 Oct 2023 11:59:39 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:30e1:c9d3:6b41:493d? ([2620:15c:211:201:30e1:c9d3:6b41:493d])
        by smtp.gmail.com with ESMTPSA id az7-20020a17090b028700b0027d157e686asm7177565pjb.49.2023.10.24.11.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 11:59:38 -0700 (PDT)
Message-ID: <64aededf-7879-4246-8c1c-bc38ea47e05c@acm.org>
Date:   Tue, 24 Oct 2023 11:59:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs/core: ufshcd: Conversion to bool not necessary
Content-Language: en-US
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        mani@kernel.org, quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        peter.wang@mediatek.com, beanhuo@micron.com,
        quic_nguyenb@quicinc.com, Arthur.Simchaev@wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231024183401.48888-1-bragathemanick0908@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231024183401.48888-1-bragathemanick0908@gmail.com>
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

On 10/24/23 11:34, Bragatheswaran Manickavel wrote:
> A logical evaluation already results in bool. There is no need for using
> a ternary operator based evaluation and bool conversion of the outcome.
> 
> Issue identified using boolconv.cocci Coccinelle semantic patch.
> 
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
>   drivers/ufs/core/ufshcd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 406885671665..bbd8e83be6c6 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2406,7 +2406,7 @@ static inline bool ufshcd_ready_for_uic_cmd(struct ufs_hba *hba)
>   	int ret = read_poll_timeout(ufshcd_readl, val, val & UIC_COMMAND_READY,
>   				    500, UIC_CMD_TIMEOUT * 1000, false, hba,
>   				    REG_CONTROLLER_STATUS);
> -	return ret == 0 ? true : false;
> +	return ret == 0;
>   }

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
