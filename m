Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433D17DDC20
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346852AbjKAEmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 00:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344644AbjKAEmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 00:42:19 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6231F4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 21:42:16 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-45b653c29faso1538277137.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 21:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698813736; x=1699418536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgH3+HSLjETT5wLuuz9AiA0y3mldkhc/pGAcIcF0398=;
        b=HPOr7tlWDtj1r7EhuTvm6NgawnYJHRhVxrQ1DeukYuYZikSK2ybtSZsvuf8IpVoTur
         /zZ3k8ObgekeLr/qpoqKTczRAphN+rSz86yXkSdBCtHgSacRnfVYI5iusD7XWrNcd/Mr
         oxIZupMjxeBxa/BTceLYDlaTaO/EkbyLwD9CNPwU7cBxB9pCUoxPNuFNgyVaRaQidmGF
         I5VB2JpuMGf9+s6pCiKTe/6ZWEREHofMLMzxr71xYJPGNCe0AxicUTjAo6ZXJwIHTQgB
         ebsjaV3PRSrUof5yrYoF9rMQxzvPJCFIEnkOLwcAV0IA1JDUgFqXIM/2a+Wd5CyQC3te
         rMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698813736; x=1699418536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgH3+HSLjETT5wLuuz9AiA0y3mldkhc/pGAcIcF0398=;
        b=HtQG3MqM3/WJ+wP5gWwADFvS/dxd68rZENgyjHsktVjd74BCZvKLtPpAKVAHPLGZ1R
         UupRsrvXNyIYcl74UiKAFvT8MBrRL4c4BSTATficg4w7oXk4sBb2S0YqcAaEPLzBdz5b
         3XzKbusNxsV5hH6U7HDezJgBISjEqeTx96C0GxCuiN3VAHnPE+Lm/Lip9pjwTf7luAxW
         BszYidUYkS1ABpE+eVpbxPiJ3N3CSvQKB6TvM4AoSNjgw3ooCanJ9iD9Wu0AVbnaaQ4j
         uA4jKU9mmKZxN/HJrAxZZSrf76DrJkAHHhhpKpUo4SGWgtNY4KdW8N0HxrCn9ImDj0OR
         mSEA==
X-Gm-Message-State: AOJu0Yyk6i5oJUwp6GcITM7qdDX7EpLEElNSGeD3MVyG+nCfNvs2juMv
        +9tBAyyA0cmrc4yHczKBPT97lQAgqpUFiCyutQZnIg==
X-Google-Smtp-Source: AGHT+IHwPNtghu32HE5o0YvdXHVy1gAosLlFpssriydow3gFdL0loxYzv/76Zvu0G96qi1rk3zj6nssPQCL3MzyHtjs=
X-Received: by 2002:a05:6102:aca:b0:457:ee76:4317 with SMTP id
 m10-20020a0561020aca00b00457ee764317mr14206176vsh.0.1698813735673; Tue, 31
 Oct 2023 21:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231031044021.1162403-1-mnkumar@google.com>
In-Reply-To: <20231031044021.1162403-1-mnkumar@google.com>
From:   Naveen Kumar M <mnkumar@google.com>
Date:   Wed, 1 Nov 2023 10:12:05 +0530
Message-ID: <CA+Hc5+5ZmywtRdu5KQ=jbgx114c8eJc=TY_KQWWyeuiAC-_7MA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add a quirk in xhci-plat for parent nodes to specify
 no 64 bit support
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        royluo@google.com, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the reviewers/maintainers I missed in the previous mail to this patc=
h

On Tue, Oct 31, 2023 at 10:10=E2=80=AFAM Naveen Kumar <mnkumar@google.com> =
wrote:
>
> From: Naveen Kumar M <mnkumar@google.com>
>
> This patch aims to expose the XHCI_NO_64BIT_SUPPORT flag to the parent
> nodes of xhci for clients to specify if they can not support 64 bit DMA
> memory pointers. This issue was observed with a Google SoC that uses
> a DWC3 controller where the virtual address's higher order bits are
> truncated
>
> Naveen Kumar M (2):
>   usb: host: xhci-plat: Add quirk-no-64-bit-support
>   dt-bindings: usb: add no-64-bit-support property
>
>  Documentation/devicetree/bindings/usb/usb-xhci.yaml | 4 ++++
>  drivers/usb/host/xhci-plat.c                        | 3 +++
>  2 files changed, 7 insertions(+)
>
> --
> 2.42.0.820.g83a721a137-goog
>
