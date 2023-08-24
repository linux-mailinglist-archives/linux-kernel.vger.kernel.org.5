Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0E1786A25
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbjHXIdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbjHXIdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:33:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0B01724
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:33:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31ad779e6b3so5321386f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692866020; x=1693470820;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6eCv+CJRAblo+rlKn3ngX1BL6rLbMlWZVG9SVzXXcQ=;
        b=vc6g91R8DSiVinfiLrkOMghI8qnK8+UxR5JNO8Iu4gVw93EyFyP7pJq+34oTppaV8q
         tL8pyGFWqIpX4ctyUhnJqPcxIFPzGQtUrUxanQXo5q8VUWXbeSjl+UdpoyY+3YhZ+Kne
         HsmbfN+StzUguuHlBr4/H6+qL280a9q1LFmL9gHXrakYBvcgAcu1QNqTfT9MZnyc0oKA
         s6rMHUJnh+a41BKbt7RlMmk92RHLIb0/i0Qe+J3ghh4Wq7wzJMJNJZhb4NaAwM1Ju6J+
         qGXzRn5nzlL68Q/oWdIjQuUMFqHrgG+StvXNEHtyfNRPI35q/CGzNmCZPAnb04qnU7ai
         LnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692866020; x=1693470820;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6eCv+CJRAblo+rlKn3ngX1BL6rLbMlWZVG9SVzXXcQ=;
        b=ZMuVNEShrU3uDRE5iDv2Qap1tlqn08FatdNAOj7DiOBwrnTQYCZAyvOfM8+1lueMjr
         SeRyMexzofoFkztVVc3zYaAZCUiovKeGzukRw7QS8xTjT+RxAlMcAoMQ4rA+Bf1XDM+6
         1JxlKctqfZvpB7Zu/qIS5/DKrQWhCy9JVDGJaxL0ptALzCW0Ox/wclSNzhrjWwWrmL+R
         PA/gAa1F/t8XdX5CZt2VrnBc8grIith8QtQdv4qY2buD04887kfi6s9eVmNqHXbrwbNd
         yJP3nLnhEhQNdpO4cdumMPPbbkl3K+ko29fp2CZYIm3pSRBCmL6pMnTAp7NxHpeIz4Sq
         UVVw==
X-Gm-Message-State: AOJu0YxZpK56IDI9l/4UwGNPxK0cDGFRWO0slXr06ZZU/V1gc5X92fgj
        qRDGKkiJjyx37M+yYOIpArQhGA==
X-Google-Smtp-Source: AGHT+IE0kJtgTKAINFdsLfUoZBXCx9cidt8kXJGBWPXQYU4ITv23+5mXDNIdaF2lT21zZZdh4N5EVA==
X-Received: by 2002:a5d:494c:0:b0:319:68ba:7c8e with SMTP id r12-20020a5d494c000000b0031968ba7c8emr10948264wrs.38.1692866019934;
        Thu, 24 Aug 2023 01:33:39 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.239])
        by smtp.gmail.com with ESMTPSA id u12-20020adff88c000000b003198a9d758dsm21622700wrp.78.2023.08.24.01.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 01:33:39 -0700 (PDT)
Message-ID: <179ad6a2-faaf-92df-1ae4-4e41bcbdd622@linaro.org>
Date:   Thu, 24 Aug 2023 09:33:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 01/41] mtd: spi-nor: remove catalyst 'flashes'
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-1-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-1-291a0f39f8d8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

you could also move CAT25_INFO into everspin.c
