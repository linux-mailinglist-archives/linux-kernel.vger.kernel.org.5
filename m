Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290F1788BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343834AbjHYOkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343821AbjHYOkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:40:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6474EC;
        Fri, 25 Aug 2023 07:40:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bfcf4c814so124655766b.0;
        Fri, 25 Aug 2023 07:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692974399; x=1693579199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFusswwH0YOVAcBlC18MK45EE7lJRCZhZwn/ixtEHfg=;
        b=Ygczodz6N1bNrbWumgl/VONtBcnxvJLnW84LtmQC/b2d7SMueR8RA8zh24DsK4/RZ6
         cD0x/n37dqsBL5ibxzX3fSR562ScX+pVAo839Ngi15p79uakQJJatgeyF0d2hQPitwKG
         f41cWcFtXKcGh+3JOMdDARpEMzCInJVkQvYF5hzxW0PUXCUJX9eEpcVbeNtzdSklbF/S
         pknSxeyxHSbh50cmuZvnGVcQbmvD+iQIJnf/CflHS+aRlN5voql2/IxwKPUrqdFtXXUh
         dfRP/4ybu6FRZyOKUnQl1HeojxDIeVDD8b4y9GEVJVua2vUOaGvj6wDsQ/kC4eOEBDzN
         +MWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692974399; x=1693579199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFusswwH0YOVAcBlC18MK45EE7lJRCZhZwn/ixtEHfg=;
        b=C78yJJlCYJvvMO936xtnbcR/+PN3yexhtzXntdKeqtz/sTafW1127n1pfVwC4vMLwo
         6dsrnza3UCeQmHU8wcuTPyNos1KQfbXI3gGFljlZ6DZUeXIx0WmlEYKJ7nnuudanC4Cx
         ngOy29J54OtImsC1eM2bIz8qEwXky7LpWCt5nGdDRC6BGMrZrxHn26j8psdGOC91lENO
         edKlm0Fu2TwxWCDSNHE+H3IKTqMBLzJ7bk8hIeuzMhrTU1Mxx4C1EjcVxU/zAnlz+ejH
         KUevskqOUdInuuU/XGH6oPL0FZtg+8z8QKUJa/kjciSWL5Zw0itJupg2D2aJZsL9zKCO
         Ah0A==
X-Gm-Message-State: AOJu0YyJPqrpW0o2bqTnHLkfWc3IkjQUA8TdoiKBRwGKLDo8bTNBzNJV
        CIQRPe04TJHESInlsidDZux9ZCFOYqINQvKTd4sUfK8Ftq1HKQ==
X-Google-Smtp-Source: AGHT+IG3aEDZ4aPAYPDc4xb7NF73dfks5sxcLfeCUEDsvuJWJT0PqA0+fp/HSOOwVc5wLh2YjhwHBoA+9AgAFYjkHUs=
X-Received: by 2002:a17:906:256:b0:9a1:cccb:5429 with SMTP id
 22-20020a170906025600b009a1cccb5429mr8328637ejl.15.1692974398889; Fri, 25 Aug
 2023 07:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230825124115.1177577-1-keguang.zhang@gmail.com> <2856de1b-36cd-1d56-734a-401def967870@linaro.org>
In-Reply-To: <2856de1b-36cd-1d56-734a-401def967870@linaro.org>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Fri, 25 Aug 2023 22:39:22 +0800
Message-ID: <CAJhJPsWcjok7WnMKkQ4S3W46VLCQd-zP_8NLrG3RNtWJVd4muA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mips: loongson: Add LS1B demo board
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 8:45=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/08/2023 14:41, Keguang Zhang wrote:
> > Add compatible for LS1B demo board.
>
> Where is the user of this binding? We do not add bindings without users.
>
OK. I'll put this patch and the DTS into one patch set later.
>
> Best regards,
> Krzysztof
>


--=20
Best regards,

Keguang Zhang
