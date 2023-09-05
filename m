Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEF7792B4B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbjIEQsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354257AbjIEKZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:25:10 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC98CE;
        Tue,  5 Sep 2023 03:25:05 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 87289408E8;
        Tue,  5 Sep 2023 15:25:00 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1693909500; bh=82wnOs2cazR792K57XsVYZG/zGApqL4J6S+GzcIbLSM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nmDMXCayMNEpCVMehcyT+sipn6UTXZnLJMSug/hoQHIFtoy3U6nT9sT8WDPK374+D
         AbAA0puWrXf//XYrOj52NqTKsy74VOhrbAo5djGM4vOM0JngXH+4ue4mrFgPE3GbaL
         GoWA0IRWXlcawDXem0TU0yw3XayuAkWj/uIyDSEF/fMx8rMLP8/+TG3JCmzxTg+9LR
         gGSgh91YcED6okYzllUyYt6Nt78PXUzxPiLvGhLiTzFrfURY8fYW410VSlCuh6Axtq
         9x/l/HwTUZ0GZuQ8VhxgswqaVpx8dWSg4he5ZfaehkU5KFCRfhAsM7g0q/JiZJ34FK
         fJouHIZv1aLfw==
MIME-Version: 1.0
Date:   Tue, 05 Sep 2023 15:24:59 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        David Wronek <davidwronek@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/4] remoteproc: qcom: pas: Add sc7180 adsp
In-Reply-To: <b85245cc-868a-442e-8f27-ae6ee60d49cc@linaro.org>
References: <20230905-sc7180-adsp-rproc-v1-0-dfea7699da7b@trvn.ru>
 <20230905-sc7180-adsp-rproc-v1-2-dfea7699da7b@trvn.ru>
 <b85245cc-868a-442e-8f27-ae6ee60d49cc@linaro.org>
Message-ID: <96006deefd7a10a65db5d84ad319524a@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Dybcio писал(а) 05.09.2023 13:35:
> On 5.09.2023 07:47, Nikita Travkin wrote:
>> sc7180 has a dedicated ADSP similar to the one found in sm8250.
>> Add it's compatible to the driver reusing the existing config so
>> the devices that use the adsp can probe it.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
>>  drivers/remoteproc/qcom_q6v5_pas.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
>> index b5447dd2dd35..55fafc68200e 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pas.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>> @@ -1161,6 +1161,7 @@ static const struct of_device_id adsp_of_match[] = {
>>  	{ .compatible = "qcom,qcs404-adsp-pas", .data = &adsp_resource_init },
>>  	{ .compatible = "qcom,qcs404-cdsp-pas", .data = &cdsp_resource_init },
>>  	{ .compatible = "qcom,qcs404-wcss-pas", .data = &wcss_resource_init },
>> +	{ .compatible = "qcom,sc7180-adsp-pas", .data = &sm8250_adsp_resource},
> Should we use a fallback here, maybe?
> 

Not sure if it makes sense to, given afaiu no other soc defines two
compatibles for the adsp right now...

> Konrad
