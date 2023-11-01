Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE187DE4EB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 17:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344376AbjKAQ47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 12:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344304AbjKAQ45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 12:56:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C674710E;
        Wed,  1 Nov 2023 09:56:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32d80ae19f8so4645837f8f.2;
        Wed, 01 Nov 2023 09:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698857810; x=1699462610; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S0+VnMXLjP+kwaicD3UwKOa7X0FEZgTGR/DFhzdFdfw=;
        b=e9R1CJI5IQOzya+hPiq+4UvkMcZlaAxrsvYl/xle/OiUhExKIA0BnPkvUHE6ysnfRz
         WRoAhhWH0pjvj9VsEGlvomj44jCMR++zevjfeqmSKdlUIk2OCiXoM87uggb6brSfOkxL
         B1+fW36/HgLCeKI6cEvEGpy66yrbh5fGW7LgBgm/EmkXfzZX1tCKwS8prSe70mBb0K8I
         NEdC120+XYTWuSYsVQpL701vWKQ47TAGXVokK4BVLLCVxjlv5AcOO0R89yCSa+AZI2Pa
         tv2Fc/6tK660f6G8JpJpXDUSRVGvKyC/8YfHVHghuSiEKKwJHMcSCeENSFriEKRJopPP
         C1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698857810; x=1699462610;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S0+VnMXLjP+kwaicD3UwKOa7X0FEZgTGR/DFhzdFdfw=;
        b=DwpENkpvfZ+oSM2mDGUfRgNbNQd3+7aF/RWlEFTD8A+oxEbi+eCnYB97gLlQSivV0k
         CyoVJ6Wz7Xk4Wvvf7/2bgNKijD+3depBlJjvfLp0lU4FbPGMMcnNawViBnRyv7vyRGlx
         AHxqk/BLWBRqglrVxzmwZXNcj1KwurOJ+LS8EsVrT8EKgIDlMeSdAALjAOO1TEgdizXB
         ZsOpNFD+rB95voRSalahPFKPyyL5+QlqT2aM1jSAF5T6REvH6f1l/Mzapmcsgbixxcc0
         BI4pyUGglvEf8lGTw0cYCmRCC6BwP4U+zP2jHGZqZP/arkOeJcUCMV+NXiJZ+qtAfIRO
         6LZg==
X-Gm-Message-State: AOJu0YxGqp4mrsAZ5a8eCBLJ3XDiN/V4rAHS/OOIwmuOsuZmAqHn+9iU
        0c0UoRwp+eQGiigrKQUjHspYffPJq9VpOxa8
X-Google-Smtp-Source: AGHT+IHF2o+XLo7Bp4Da1VvTAEL3ByKPXqpsG2E0CpQPMblrgGQu9/SAX5ghd4j0uprkKYS0Q6FaCA==
X-Received: by 2002:a5d:4b88:0:b0:32d:8872:aacb with SMTP id b8-20020a5d4b88000000b0032d8872aacbmr12772549wrt.53.1698857809842;
        Wed, 01 Nov 2023 09:56:49 -0700 (PDT)
Received: from [172.23.12.176] ([85.119.46.9])
        by smtp.gmail.com with ESMTPSA id b11-20020a5d4d8b000000b0032d8354fb43sm252616wru.76.2023.11.01.09.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 09:56:49 -0700 (PDT)
Message-ID: <85ec355fdaf9d4362f34bdf2e1aded9a9bea9850.camel@gmail.com>
Subject: Re: [PATCH v3] scsi: ufs: ufs-sysfs: Expose UFS power info
From:   Bean Huo <huobean@gmail.com>
To:     Can Guo <quic_cang@quicinc.com>, bvanassche@acm.org,
        mani@kernel.org, stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 01 Nov 2023 17:56:46 +0100
In-Reply-To: <1698811243-5024-1-git-send-email-quic_cang@quicinc.com>
References: <1698811243-5024-1-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-31 at 21:00 -0700, Can Guo wrote:
> Having UFS power info available in sysfs makes it easier to tell the
> state
> of the link during runtime considering we have a bunch of power
> saving
> features and various combinations for backward compatibility.
>=20
> Signed-off-by: Can Guo <quic_cang@quicinc.com>

Reviewed-by: Bean Huo <beanhuo@micron.com>

