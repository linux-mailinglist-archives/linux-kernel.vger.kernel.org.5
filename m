Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BCF7CBCD5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbjJQHx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbjJQHxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:53:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D037F7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:53:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso8271806a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697529202; x=1698134002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hlgpw+L9LnX18jEvUn1qVQk3D6pVTwN3aQ8ouOWfzN4=;
        b=hNq7VUC1XJIOXJyBPdsK9n+DYKu/BQTRpekJt1wbpsGrdpifQo0Gm3a4geRBUsB03r
         chNtpBwSb/SG+Ase0kG9FznvAfQy4oE8b7/yLfETXpM8eyucxlBJL7fgFlU77vc0Qcr6
         ER2eVT0U02mo7jKNe4JFzNgiII4HJW7WR4b6NuJ17GynfcvpVT3Wospd0rW1KKnUPB/C
         t7spBzbvZbLid/0+BN4NCSfmNMdRUROhfcKbfdyDeeDem1+khZwPNS2EFyDSe2Vomvus
         KDUHZIuESs39Nyu1z/81vWpCCKaLuQuRzaK9Eebc9HqlxDZVZESCAT1mv5dnzk56tCV6
         bTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697529202; x=1698134002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hlgpw+L9LnX18jEvUn1qVQk3D6pVTwN3aQ8ouOWfzN4=;
        b=U7uSk42fufxnImlcRAUjS6K5LNHdvcKSyiEvt9MK9hlfZ7ZZcvcBV0LLXAVu7kD4Qu
         QsyOpV3osqApAFJWlf2g60VHNLXh3UWgEXQNNWNLed5sWFPq/E2Rx+wJv9hV+FqUqkRx
         VQtPzaodVFJFE/iK5VCfNWUf2I7HvGVyj0o88MZZUmnzhIEm+qMJXfnF1YdA5/n9vWrU
         MA0hmBPiAy2cM7te0Mp3menodyVubBTcUe5GqY9Zse0lSK21b/m0kP25g0X/0YLD+cJO
         wp9diKXDEFilJbtm/pKS5EEmpKtjNlS9fjfylj2oxenrtutFTuEuqkzDdApL8FuxGCE9
         9+OQ==
X-Gm-Message-State: AOJu0YyKb2M+X55ud7PuMfPf4gNDFPxSfermOEf2Q+FUFRCeKKMmTOLE
        alcpt8rVN8/MhRZU0KWmQWqMxg==
X-Google-Smtp-Source: AGHT+IECmWy+rb4TCclYHjf+L6Ub5W2G/aphVU/dH8jOzcsB0h3R87eoDggRzvLGB1UVpAT4fB2W1Q==
X-Received: by 2002:a05:6402:26d4:b0:51d:f5bd:5a88 with SMTP id x20-20020a05640226d400b0051df5bd5a88mr1310383edd.38.1697529201829;
        Tue, 17 Oct 2023 00:53:21 -0700 (PDT)
Received: from [172.20.10.8] ([213.233.104.181])
        by smtp.gmail.com with ESMTPSA id em6-20020a056402364600b0053e37d13f4fsm706539edb.52.2023.10.17.00.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 00:53:20 -0700 (PDT)
Message-ID: <5a488a21-596d-48f4-bfdc-28b206542563@linaro.org>
Date:   Tue, 17 Oct 2023 10:53:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: micron-st: enable lock/unlock for mt25qu512a
Content-Language: en-US
To:     SHUKLA Mamta Ramendra <mamta.shukla@leica-geosystems.com>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     GEO-CHHER-bsp-development 
        <bsp-development.geo@leica-geosystems.com>
References: <20230705154942.3936658-1-mamta.shukla@leica-geosystems.com>
 <19800e51-a871-be9f-9eb5-5829237e2613@linaro.org>
 <a8271289-0611-4e37-cf37-0be19a85656b@leica-geosystems.com>
 <084ed945-7674-280f-5866-9238473a294d@leica-geosystems.com>
 <17989610-d069-40e2-9b4d-7ca6bdf2497e@linaro.org>
 <a24d7b3b-4077-9dbe-49ae-96f595b42223@leica-geosystems.com>
 <2d7271b3-dd60-44bb-9700-f6a5295ea873@linaro.org>
 <372046cb-9135-9a6c-fdb7-307a42f55b30@leica-geosystems.com>
 <a86b93c4-a507-47c7-bdce-4aed8dfcf929@linaro.org>
 <eb2a9138-a76e-4b1e-e001-315149c4dabd@leica-geosystems.com>
 <f0a7acb3-00b5-433d-af5c-724a509fb816@linaro.org>
 <bc76767e-00c1-47ca-9a27-2aa7d2a262f6@linaro.org>
 <b9b7bb93-fe23-34dd-6a30-b1b0d792861f@leica-geosystems.com>
 <2e3ce75d-7e2d-4e62-8660-48a41074c20c@linaro.org>
 <fd6b5e43-7e90-b98d-79be-0c65840ec433@leica-geosystems.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <fd6b5e43-7e90-b98d-79be-0c65840ec433@leica-geosystems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shukla,


On 16.10.2023 12:39, SHUKLA Mamta Ramendra wrote:
> v3:
> https://patchwork.ozlabs.org/project/linux-mtd/patch/6b89ae4e4d7a381050746458cb000cd3c60f7a42.1696849423.git.mamta.shukla@leica-geosystems.com/

I've just sent v4 on your behalf to speed up the process. Please check
what I did and if it looks good to you let me know.

https://lore.kernel.org/linux-mtd/20231017074711.12167-1-tudor.ambarus@linaro.org/T/#t

Cheers,
ta
