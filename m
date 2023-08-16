Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7A577D75D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 03:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbjHPBJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 21:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240987AbjHPBJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:09:20 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB73B268D;
        Tue, 15 Aug 2023 18:09:12 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b9cd6876bbso1603429a34.1;
        Tue, 15 Aug 2023 18:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692148152; x=1692752952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NSkEH/9Z3XQRfMyS98L8/MPpuGgYuS2fQa5TuY149uE=;
        b=YvVbDNYWtmke5r+BFoaiJW3pq+6BH17n4jsoOYmt1XDJ3dHrjANAYfxQVwqqYIuVHh
         hVnFilqdYGJTNpiXOpKw0qFq251aHUnOTc8ZnW78i2VD+TGtbvpLwuVMeqO/qDHuZTKV
         0JkafwmHHwwYt2RBaBdpcMO2w//5idfsQwJ4KGPDVvKxZlalfAsDczlFCREnWU6tWgIO
         IlkS2WLEiQ/fhoXagPPFqyW9mD5MTdYNJT8rBS4HtpF6IzKntZ5/WIZR0MDDj75SDveX
         +nIMYJmOXOY6LW4lytxGWQ3ubqpMVXSCXq6yy5aTUyfNn8hUMwJxBybatmeIixZYu3+7
         eW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692148152; x=1692752952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSkEH/9Z3XQRfMyS98L8/MPpuGgYuS2fQa5TuY149uE=;
        b=Ov1zMvNi3K/ND0SUaI7c9qd8lMLcqHfQxOUoBokvf/gOJo1XpKMd4xQfnaXPCT21VQ
         msdSfDEXD0VwlxX6RzJomdgk9Vpah1cykKNTMoiSFHVY3MqR175JtKsqs0GXzBFlOGea
         93saJQPYLfuyE6eJlUj5EqdcGttnQ0UaTJz+2PHAT/U100RwTwFs2qq37lLP60Ka0ePl
         sIOJr69OURg/DhyoG7wybqcWv7ulKOq9AG6UdMc0+msvgOfFuOX946WSPNxTxEmjuTuw
         P6hwmrDFMa9YJQpAHn7EWpKVDhb9rQxibTtwJ/ECocRR+IMysgeHFF+rgRUTD0WYf43d
         mzcg==
X-Gm-Message-State: AOJu0YyZMbzrVfibJk+qsYBlGL4sD1gXFls1IIr+FcOoi4JRkUPteCSh
        i5oeyUbnmteeGc+IYX61jig=
X-Google-Smtp-Source: AGHT+IEF1hcMxMdsNg+davQYwzBYH0iK/IPiOlxi5OV7huxZ5R1Ounlk8rluR8E+dbqWda3ieyyrXQ==
X-Received: by 2002:a05:6808:1827:b0:394:25b9:db19 with SMTP id bh39-20020a056808182700b0039425b9db19mr409770oib.2.1692148151894;
        Tue, 15 Aug 2023 18:09:11 -0700 (PDT)
Received: from [192.168.0.82] ([67.6.79.63])
        by smtp.gmail.com with ESMTPSA id s22-20020a0568080b1600b003a4243d034dsm5985013oij.17.2023.08.15.18.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 18:09:11 -0700 (PDT)
Message-ID: <2980f5e6-40b0-4ab2-ae73-bceeb97b4de5@gmail.com>
Date:   Tue, 15 Aug 2023 20:09:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] Input: Add Novatek NT36xxx touchscreen driver
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dang Huynh <danct12@riseup.net>,
        Amit Pundir <amit.pundir@linaro.org>
References: <20230808-topic-nt36xxx-v10-0-dd135dfa0b5e@linaro.org>
 <20230808-topic-nt36xxx-v10-2-dd135dfa0b5e@linaro.org>
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
In-Reply-To: <20230808-topic-nt36xxx-v10-2-dd135dfa0b5e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad Dybcio,

On 8/8/23 18:38, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> This is a driver for the Novatek in-cell touch controller and
> supports various chips from the NT36xxx family, currently
> including NT36525, NT36672A, NT36676F, NT36772 and NT36870.

In kernel v6.4, a basic novatek touchscreen driver was introduced [1].
I was able to tweak IT a bit (add devicetree compatible, regulator 
support, remove chip id hardcode) and get it properly working in my 
Xiaomi Poco F1 which has Novatek NT36672A touchscreen. Probably the 
other ICs will also work. So, do we really need a separate touchscreen 
driver? Maybe the existing one can be improved to add more features if 
needed?

Personally I have been looking forward to the v10 of this patchseries :) 
Thanks for working on this! But, yeah, we need to decide if we need this 
to be a separate driver.

Link: 
https://lore.kernel.org/all/20230326212308.55730-1-hdegoede@redhat.com/

Regards
Joel Selvaraj
