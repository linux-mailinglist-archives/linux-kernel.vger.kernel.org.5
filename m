Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D577BA24E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjJEP2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjJEP1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:27:47 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B0521A2A;
        Thu,  5 Oct 2023 07:48:17 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1dd4eed487dso659376fac.3;
        Thu, 05 Oct 2023 07:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696517288; x=1697122088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFHmzKPqEL1IkLNEOF7MGTVK5JnE7Z6AEnyd82Qfqa4=;
        b=IN4d99ApaeKhBZi3NAetUfmoLG5KmXvmfABB9WW32txzsL4D/l3F2JKjfyDgOOnAxu
         ibzu67t8DZ0cFs5V/upkwz9mqol4vrLAflxu6YqKu9n+zTqtVHh1SYH0O65dHUe3odsA
         353ry3wpSIKj8Vjho6tx6zz1X6cQlsix03gdPQWWdG9vMSSNdG/HNmrgkZNZSB7Oj8rc
         dnOj3hgUx3TcwAKHM97cUaRC3HwD9moVG4bzKcN584/gnYp0eBVXYIpeTTKesseSIK8M
         gkhK+hRBpoTiNKoe+Who7qmrRc8BTcoO8aNdaOaC/QCezQO1O78wBt7pTmD6wFNONtpB
         VP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696517288; x=1697122088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFHmzKPqEL1IkLNEOF7MGTVK5JnE7Z6AEnyd82Qfqa4=;
        b=H1Kea3iCd8JD/NWmacEJ6INufvMFQbvbOZRXQAxEdD+pFYo5rcrh5lKYkuXAeveAgZ
         EziREAfl5flJ3Ixx8mBjglAvaLfGXPOCWbe+0h0t2eZujb8J23kcDhw+aFebww2jeNYn
         Ty+tHItNxphyZH/H8qTr2fsFMqbB7X+THGIZJ3+AwpDJip+UvXnF4z9I+YwmS+50kxOp
         ZuxD50yTEHDOshlIsqWJ5vZc3AqnTKk+C0HGYi5USG0B/uLDHQtdivf6UsKGqoZc4Xsx
         zGypLj1Ut2HjWWzq+LO66p8HdLObSnfa+Yu4cObqIF6cdsAQoe7lbnj8Hw6whN1LdBxV
         Bang==
X-Gm-Message-State: AOJu0YyQfsVVZ56UPb2dp6mKKcgup1CLaX7nU3oFIgOPxLzKtngBlo5p
        +XUtGLoMZpTbdVqXLwDfBwylzOO5cxxOn+W8AyapaNizXnY=
X-Google-Smtp-Source: AGHT+IGnl1Pk7F/KSz2dgwrjyZeemiswBz/QKHtQVnyuJ9bOGr3K8xBX7W4X5wPWwL53ZMV2OLDF463z8mdIe93OPA0=
X-Received: by 2002:a05:6870:5ba6:b0:1bb:9c27:c7e6 with SMTP id
 em38-20020a0568705ba600b001bb9c27c7e6mr5704458oab.41.1696517288135; Thu, 05
 Oct 2023 07:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231004161038.2818327-1-gregory.clement@bootlin.com> <20231004161038.2818327-6-gregory.clement@bootlin.com>
In-Reply-To: <20231004161038.2818327-6-gregory.clement@bootlin.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 5 Oct 2023 16:47:57 +0200
Message-ID: <CAMhs-H9Y=7j04mienYdqCPJYFrH9ms6UarbtVzEDFzxwSPuLuw@mail.gmail.com>
Subject: Re: [PATCH 05/11] dt-bindings: mips: cpu: Add I-Class I6500
 Multiprocessor Core
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 6:15=E2=80=AFPM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
>
> The MIPS Warrior I-class I6500 was announced by Imagination
> Technologies in 2016 and is used in the Mobileye SoC EyeQ5.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mips/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
