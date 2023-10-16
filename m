Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2227CA58F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjJPKgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPKgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:36:22 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44575B4;
        Mon, 16 Oct 2023 03:36:21 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-692d2e8c003so4034305b3a.1;
        Mon, 16 Oct 2023 03:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697452581; x=1698057381; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q2KxXvKJ4hS+PB2AiU6pcTyy4KdWQHAlutJ0YuwP+kY=;
        b=eWlR64ByB+PzjUm6/asjw4y7ZfUqd1X0jEsi4UQRcd20EuUp6BdLvroWqHa48rzmws
         Js6K5oGkKBNZwjuewQCAT3sXI7O942kbnAdasnERK8DB1P77T8LiwS981rbinfbpVNeZ
         Z8DSmq8DOrsKiXIHs4XaYSinJsEVX/VVcxZcS+ri7TeGs0znqwseZQ5hkp/JiPeHM41I
         Crhaubi8TPjdvLJ1DpJj7xeB6hrY9jR19ZjVwogTNSQX5DWoKUkLhlsSH+dzA5sgdbyT
         0JWdb4gQ2OJOBrEe+vWfJqsjTojyVeoYtS7iDZ2gXbcOPMQvF/ofPcXmGDPccus5KsCA
         Pyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697452581; x=1698057381;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2KxXvKJ4hS+PB2AiU6pcTyy4KdWQHAlutJ0YuwP+kY=;
        b=VCmO1HvaPnKHUodn2QIxI2yNLdBKbaEscH8fipG7R4eOGGoawE6Cz6CpaVxav5f+CM
         caoXXbbcMjsJeL2xIN6l8pKOyf5E0MMlavzK3QsU+m187rUQd3wgb21pN9bLWzhW7Dgz
         yduqorb8iCsj+d1X16DDZIQ9SGj3ENMzulJBqZ4y/t6CLYUIclH3duoSpW4BxOmuL10U
         u5+VunEWvc4TUh13nZeNAYp8N1ejRRBM8SaQSA03W1NTr7CNtEeTwXZdJLT5Ijq+TmdE
         cM0Mm9uUNbywhfpkurkchhJvbVV57UoIQh9vvw7Lzvi72Me3sxowopJ5/ikRXOGx6iQw
         P+rA==
X-Gm-Message-State: AOJu0YxfTKklCxV7XohhiL3ZOwhRSf3mqOvMGzkiLudRLNyN4nYEc0hz
        pEfimu/TS1n4Pfh87/KvoM3s3XEMVSuFaDB0OO8E1h8i
X-Google-Smtp-Source: AGHT+IFI+4YF7PxqFcPOQIhL5AEQKo/a7pq1byi9QX8exo/648kRLc6pbqySkjD0Q8tvvqrDGiNudgY48DIjipvqEgs=
X-Received: by 2002:a05:6a20:8425:b0:126:42ce:bd44 with SMTP id
 c37-20020a056a20842500b0012642cebd44mr11241356pzd.17.1697452580684; Mon, 16
 Oct 2023 03:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231013172033.3549476-1-robimarko@gmail.com> <20231016033202.i54nequofzea6mfd@vireshk-i7>
 <20231016082239.2onlrqp4bpcgxhbt@vireshk-i7> <CAOX2RU5paPXyG-1Fbp+T9+Aycwno9DQ8ugMwUr_8iNhhc3HiHA@mail.gmail.com>
 <CAA8EJpq9=dtemYLCeL8=+q1x_i8Gp2duMSAo90ZttgaejBXCdg@mail.gmail.com>
 <CAOX2RU6K7h8Xc0SGK2CeOCaAaimKRf9eqhMYAaySXxQLZiUNtg@mail.gmail.com> <20231016103106.kyeritota2mnutcm@vireshk-i7>
In-Reply-To: <20231016103106.kyeritota2mnutcm@vireshk-i7>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 16 Oct 2023 12:36:09 +0200
Message-ID: <CAOX2RU7_tu0VYScSLb=vGcT_8H_Mz_zve+DJGx9G1yLx+LfQQg@mail.gmail.com>
Subject: Re: [PATCH v6] cpufreq: qcom-nvmem: add support for IPQ8074
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, rafael@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 at 12:31, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 16-10-23, 10:43, Robert Marko wrote:
> > Ok, I understand now, the thing is that the ID-s were added for
> > socinfo initially but recently
> > I finally had somebody with access to the Oak HW so I added them to
> > cpufreq as well.
> >
> > What can I do to help this get resolved?
>
> Rebased over Bjorn's commit (which he already sent in his Arm SoC pull
> request) and applied your patch again.

Thank you for your understanding, I will watch out for possible cases
like these in the future.

Regards,
Robert
>
> --
> viresh
