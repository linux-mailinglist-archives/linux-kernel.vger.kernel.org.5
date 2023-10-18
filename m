Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3402F7CDA0D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjJRLMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjJRLMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:12:41 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583D0FE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:12:40 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so78862561fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1697627558; x=1698232358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDpHPJE+BkfTNRDkUeRRpPFsjN3yGYmtd1M6xO6lbDg=;
        b=aGaIL9WuKE4W4/Gl8Y+KR92EeOn2jvcdJlMstxyL7FQpRLK0XKXSy7teXaXwiURyfz
         g9kfWnJaMWIfzLLz9CSVUYZFKLKWZefhsGp94tBqZXd2L0grF+wYcFfdZQwcL7c+3dIZ
         OyPjusdh5qQ0ZHtD52BhQnSy41xQdTcfkzjvdHW7fUMh0k50RU79dgZe7pnBbLMXaaPR
         Up4l9CrGC1Ge59OMsEzhpwBXL3ErqSG1BnikFkH+w11B3lIFlQ8aL1uc/mATMSAGs06j
         xYqkVYb4ZaCuKy1VyUcprue2cLuik5PUrbWhBVlXRgDB4p7RBvQ9makCDo1q9ogR4KiT
         Nijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697627558; x=1698232358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDpHPJE+BkfTNRDkUeRRpPFsjN3yGYmtd1M6xO6lbDg=;
        b=HjGLPrh/pic/tKkn+WdJ4iYBGk6O0s1tWaWwkQrVVGBxod7uHLfZERnriTfyNuZOyd
         40NV5pj//m+q2Q5vVCvFGPdHC+O4df7sX/FlVGqgE07kIOAdgYQVGVCi6mjPDS4luWpY
         ym6Cxw+T+4KziTc2bDzIDz03a0K2aPfN45U712il3K8/qE8WtEQ94/69oaa18nht37rF
         sD76LNgTiFnJhOhBqb1u/oOiBUnAr4nJyBoIS2QsgXpoNVgz3vcxE+7UlAMD/LigaVfx
         qkvOLfWjkDQqVXtDAyCxTPUvH+nwjlAq3h0qIQzdg7BFhcL7tn+FbpRBcK2uSZOlJibK
         ss0g==
X-Gm-Message-State: AOJu0YxRJFcGBGhd156pT+uzJwqJrZuBXMazWezPNg1FLT3pDRgfMZS+
        VlTMdS/mYZkJdY8aCclCX7W5k3wCRqAzj7j95qbY+Q==
X-Google-Smtp-Source: AGHT+IEcadxu+rrzOiZNQ2yTDTNJ9ADljxG38fepzRX4LyaanMpNj7OlpP3Lkss3jCyK8vf54Bo72NjI3VENeLXhh0Y=
X-Received: by 2002:a05:651c:503:b0:2c0:c6a:d477 with SMTP id
 o3-20020a05651c050300b002c00c6ad477mr4822094ljp.18.1697627558665; Wed, 18 Oct
 2023 04:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <202310172247.b9959bd4-oliver.sang@intel.com> <CAKPOu+_T8xk4yd2P4KT4j3eMoFqwYmkxqDHaFtv4Hii5-XyPuA@mail.gmail.com>
In-Reply-To: <CAKPOu+_T8xk4yd2P4KT4j3eMoFqwYmkxqDHaFtv4Hii5-XyPuA@mail.gmail.com>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Wed, 18 Oct 2023 13:12:27 +0200
Message-ID: <CAKPOu+87SC1Gk7vgRC4dmBYQ4REqeEq0seFqTwngPSe=z9pn=Q@mail.gmail.com>
Subject: Re: [linux-next:master] [drivers/char/mem] 1b057bd800:
 stress-ng.splice.ops_per_sec -99.8% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 12:21=E2=80=AFPM Max Kellermann
<max.kellermann@ionos.com> wrote:
> I think this might be caused by a bug in stress-ng, leading to
> blocking pipe writes.

Just in case I happen to be right, I've submitted a PR for stress-ng:
https://github.com/ColinIanKing/stress-ng/pull/326
