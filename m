Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228E578B7B6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjH1S6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbjH1S6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:58:47 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8326BF;
        Mon, 28 Aug 2023 11:58:43 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-68a402c1fcdso2412176b3a.1;
        Mon, 28 Aug 2023 11:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693249123; x=1693853923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fK31F9cafBzF8CUN76FooxutzNLW1cai5sPG2/i18LY=;
        b=G1zLLWHR0M02qkUiK3qLCqvc3iaiqtkspsWHDZwFIHsPTcR3bGUFEIBAL64CbCUI33
         6rNdmbspGD6MkF0UlsvfqnAk+vnIZZ5J0zRBIl+J1MoUqfRhU5pxkG1Qda5oPKVGWDH3
         DR6hDGfYPVFwN9FGCQVfuBghOISZb21Xw4FbLsWlZruCGsrHKYYASnRkLxAJYFddbnjp
         lDWWDLT0CftV1O+k/7VsMu9wOjAGs8zg9Y3HJBpxKFLx01VKgh5CgT/fOykxke6Ye8jQ
         mP7tIJqOcql3lS3ci4OdiNwHaI64ZgsCGy8DPe2QL5oJ7iz5jR1HCYPf87NDULCp0fuq
         M33g==
X-Gm-Message-State: AOJu0Yzqw3jDcAbMjW+U449GbD/k3vyY8xYt44B6Lje3VlMlMfw7G/QF
        41f8KExAdGy7FywgT8+zSk8=
X-Google-Smtp-Source: AGHT+IF6mcOgWHsxnO5SN2JW5V0RBAz2U1MyDf5EJzUiHEDnFd9MfhAnMeNglXIJ9tbcdQRyQ3zVpg==
X-Received: by 2002:a05:6a20:12c2:b0:138:60e:9c4 with SMTP id v2-20020a056a2012c200b00138060e09c4mr26361178pzg.23.1693249122797;
        Mon, 28 Aug 2023 11:58:42 -0700 (PDT)
Received: from [192.168.165.167] ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id e17-20020a62ee11000000b006889601aba4sm6912716pfi.210.2023.08.28.11.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 11:58:42 -0700 (PDT)
Message-ID: <80acfd34-a4b9-43c5-94f6-f1120b81e08f@acm.org>
Date:   Mon, 28 Aug 2023 11:58:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] Changes for UFS advanced RPMB
To:     Bean Huo <beanhuo@iokpp.de>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org,
        jonghwi.rha@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230809181847.102123-1-beanhuo@iokpp.de>
 <07a52c7643215c2dedd541df60c1a8499666f24a.camel@iokpp.de>
Content-Language: en-US
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <07a52c7643215c2dedd541df60c1a8499666f24a.camel@iokpp.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/23 13:00, Bean Huo wrote:
> what's opinion of this series of patch??

Hi Bean,

I had not yet reviewed these patches since my employer is not using
advanced RPMB. Anyway, since both patches look good to me:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
