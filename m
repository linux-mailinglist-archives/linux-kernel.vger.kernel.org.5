Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5847DA25E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346489AbjJ0VWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjJ0VWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:22:53 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742A41B4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:22:51 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6ce532451c7so1634828a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698441771; x=1699046571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xl4zXkHeuFWcpQhNv8s/3dbQRenrc7EurtmB89vaheY=;
        b=NnRhdUqmFvEbncJOszNYxC+TzAmy8lf+FxlVYFom8vwas9FHwo82kaqjvWvAZ3mkOx
         Sjh2J9i3I1o8Ks1KrcGbmlgkWt7tnUlAha3nyNCp3u3r3AOVryhhEvCYH1V6xIwiHYRo
         /n358h0aKVIfKZbRC3TASX5gQ1oQIqSw9cTwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698441771; x=1699046571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xl4zXkHeuFWcpQhNv8s/3dbQRenrc7EurtmB89vaheY=;
        b=WzsXQ8K0NFsxwkbJuTyewUCeJ1EMkK20BqzWgBcXaju3HAUy2cihGQC5WDqDnI+RNP
         DWd1O179RU/WPreMTjrwPCUXrX+UkJYHAJqMiJlOqvcDTerYCcmE5/BfHYef4PP3z25t
         dT/E2wKk3bKjl1Y0XJ5GQhIvRbx84jgXyBVlQ3bzeeIJm17CUSWegwBOsfL04JPQd+Wt
         qLKdkVbc4kznThTZMkoyWidCPGCWGw3Coai9MKsi5x5KgfYvzpS3sle8EFRVKHZ1CgzG
         xtJX5sTtNAFxxe4x1A0FCMyNr7YUWh/a6BQTIx8Jb2cBIrOTTngr9692XacRtHfK6/U9
         y1og==
X-Gm-Message-State: AOJu0Yzci82b49EVVzcl9FEXtc20YybdalpaRhsnDEezHWQyE+fsg9P+
        UKzK4uE+/TYZjf49c1uZx95bw+7ttfKMxFfwCHSJOprmD8u0fXYE+fk=
X-Google-Smtp-Source: AGHT+IGtyxsQVIElVPhn4PwChycLoUO0IBnOpJTJJlENkGw49YyMfxoENC/+K3LcbH4aiI2vBYPF62ksN+R8KRRbXAw=
X-Received: by 2002:a9d:7499:0:b0:6bc:8afe:8a15 with SMTP id
 t25-20020a9d7499000000b006bc8afe8a15mr4025416otk.38.1698441770745; Fri, 27
 Oct 2023 14:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231026191343.3345279-1-hsinyi@chromium.org> <7b737537-38f2-4404-b469-c67005cdaf83@linaro.org>
In-Reply-To: <7b737537-38f2-4404-b469-c67005cdaf83@linaro.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 27 Oct 2023 14:22:25 -0700
Message-ID: <CAJMQK-jQUHz8-hEx4DzNU3cOnN59JG1xFBPH5mUndLV-rbk+Jg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Add a few mt8183 follower boards.
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 4:17=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/10/2023 21:09, Hsin-Yi Wang wrote:
> > Add makomo, pico, and katsu which are mt8183 followers.
> >
> > v4: based on https://lore.kernel.org/all/20231025093816.44327-1-angelog=
ioacchino.delregno@collabora.com/
> >
>
> Where is the changelog? It's already v4 and still no changelog...
>

v3:https://patchwork.kernel.org/project/linux-mediatek/cover/20231025215517=
.1388735-1-hsinyi@chromium.org/
v2:https://patchwork.kernel.org/project/linux-mediatek/cover/20231024212618=
.1079676-1-hsinyi@chromium.org/
v1:https://patchwork.kernel.org/project/linux-mediatek/cover/20231024000724=
.57714-1-hsinyi@chromium.org/

changelog with previous version are in each of the patchset. eg:
https://patchwork.kernel.org/project/linux-mediatek/patch/20231025215517.13=
88735-5-hsinyi@chromium.org/

> Best regards,
> Krzysztof
>
