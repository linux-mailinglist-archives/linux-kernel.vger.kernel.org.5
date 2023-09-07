Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27450797DEC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbjIGV10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjIGV1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:27:25 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3311BCD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 14:27:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b89b0c73d7so2497585ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 14:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694122040; x=1694726840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfkT0bUg5dFL0RmzhNpX1DLqx8M5IR6kOY1LkXY1afw=;
        b=g+XOWtoIE/ibQn0FJrDND5KU+PZ+xvyvKBTF8F6zDEh0ZO/huL491G2Gdqw6qQ0XUs
         yqdV6uDNI297dy5k7eO1RMj6NIhQnTy7AXrwWNRwh/WEy1xPRKnJ5d7dx0iuRvtNHIx8
         obCLpvhPnbj08xzy2CTkeo6ToOW/vfFLPeECkg5ib0FOm4akEF5eCSml6EkWCn5bfF9U
         LwG8hHrNjWDeFVY7+hGWCUp4XWbD+LhPNeb8MJUd+fz2S9L/M14k3ZdeEU4ILqiUuwaR
         gvrBqqOrWfvLkdV1fvcih25QRWvRdXoIGC7/sNVVNbmcUZh3zN6yVX59UB2dY2uF4j7I
         GvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694122040; x=1694726840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfkT0bUg5dFL0RmzhNpX1DLqx8M5IR6kOY1LkXY1afw=;
        b=I7lEnRKeVr3JUvC2UfFWK17TdwmANxpQ3kIWXLndRaXk5ojV4URjNc6Xxt+CRowyru
         uXbhoHANWqKCJqFiQUf6WwY7M2Hh0QJQbKBIJA0bMcShXB8kaoKu4u+sg6ngA10xKxfA
         IrtUtTO/g24CLAYT1seQjzEnQRakUitToRtJL/UdsgodCb8zLiVP8nPkR31YtrGmtXh1
         N8G8JtblxkBaGom5bZIDzBvJ03dDBJDBd+lKGv0HsGZc6fxn1H/s21xkyjrG1CcFTg+C
         DJuXJObqtRu9OM53tBLRpOxizoBIWYCcD7zpHLyl7ljsSw2DzZCQyJTuAy2bX8PjDqOy
         y4/w==
X-Gm-Message-State: AOJu0YwjIJdqupD77d1W9E2FoNR6vMOGaqNfARqQUOXMK8Rg8XGL7Ysw
        hv1RizZq1DeyPQWMw2cEkqXvWw==
X-Google-Smtp-Source: AGHT+IHR7HofpF9T2MmNlZB6esIBkpsiTRR+T3BVuKS/LfV0XwDwnA7XryRIc9xRtzRHN5bkByOCfw==
X-Received: by 2002:a17:902:ced1:b0:1b8:a469:53d8 with SMTP id d17-20020a170902ced100b001b8a46953d8mr889000plg.0.1694122040232;
        Thu, 07 Sep 2023 14:27:20 -0700 (PDT)
Received: from ?IPV6:2600:380:7457:42ac:56e5:c632:552:f5e0? ([2600:380:7457:42ac:56e5:c632:552:f5e0])
        by smtp.gmail.com with ESMTPSA id jh2-20020a170903328200b001bc35b14c99sm188752plb.212.2023.09.07.14.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 14:27:19 -0700 (PDT)
Message-ID: <7df3e30a-aa31-495c-9d59-cb6080364f61@kernel.dk>
Date:   Thu, 7 Sep 2023 15:27:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING in __floppy_read_block_0
Content-Language: en-US
To:     Sanan Hasanov <Sanan.Hasanov@ucf.edu>,
        "efremov@linux.com" <efremov@linux.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
References: <BL0PR11MB310616FC87790EFFEDCC7CD0E1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <BL0PR11MB310616FC87790EFFEDCC7CD0E1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/23 3:21 PM, Sanan Hasanov wrote:
> Good day, dear maintainers,
> 
> We found a bug using a modified kernel configuration file used by syzbot.

[snip]

To the best of my knowledge, nobody cares about floppy enough to tend to
any of the syzbot reports. I would strongly suggest that any testing of
floppy by syzbot gets disabled until such time that a) the driver is
either re-written to not be a piece of XXX, or b) someone motivated
starts tackling these reports.

As it stands, it's just noise in the block syzbot reports.

-- 
Jens Axboe

