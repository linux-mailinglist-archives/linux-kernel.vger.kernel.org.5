Return-Path: <linux-kernel+bounces-20013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F183582783C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5701F23A3D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A7B54FA0;
	Mon,  8 Jan 2024 19:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KccVwIMV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64DA5576D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-557a615108eso2309a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 11:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704741224; x=1705346024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oXQEvZyRm83EC0SdphMRj69tozvt9DFLasvJhLf/LE=;
        b=KccVwIMVrYMTbAd5xZYhE4O3dGD63qx+gbJodl3V2UFPJ2j360qi+l+uhuxP6UTQ3N
         5oeUDc0ioui0Kxio+fUtFhvg3Yf50B3burL/QshR01HEclBM2/aPFNCexSYLrV4gAKYa
         HssAnQ9cP0Q7VeGFJlc4FyD8G3TR29l7NHX5k2sbr1ONWroubiymSCMPhDSZTxhllXmv
         KDiLMCuameKwYFSd2b9tebKLGywjymFS3MuiMiJR7QMDFGSvqhT9mM1YvoIrqKHJQput
         L+c974SjSYOFkAKZ1RLKE8+lN67jdrrApw4bmUFHEprnbN7jZuljDWOL57G5hgKcl/3E
         LBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741224; x=1705346024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oXQEvZyRm83EC0SdphMRj69tozvt9DFLasvJhLf/LE=;
        b=jg291gKICmQqH+R52MQgwMEizVzExEur8WCmct6a0vgQ5o/dC07fzKpxm0renAt0d3
         aGY9hzTZSakllh+5MUgGv8746fQXTxIKMin+bv2VGHwIRFJ4MscE11F4csNLpU9k20rV
         a7uKqEHClXeuLh1AhCnB9n/FKsN+Oui+c9hRtRqzYQI0OWH4SbvCzq0+e2q7OWX6BUCZ
         iuX3jIuK3H/kDexceOfZRRx1eCyk+9pfscd1f1/Zq1la08mmO4oMQdGymp01kJ2FCkUF
         bz0R5nAhpjHfN4q6D/gAN7Hr8glNa2ek7HwBlX/5RJyIyFqzTmVnprGCcQ2hJj+BH6KB
         OKtA==
X-Gm-Message-State: AOJu0YzMT7JU10sieE/imauZRy07YQDfo9lNAEzlWFEn2tuO6PKMzkZ2
	///gnaZvAfBjFc+knANO6KTI7+e73Tmx9Z9Z8Miep2YvUqA5
X-Google-Smtp-Source: AGHT+IEe9b/BGjK21pYspxexkEyrcJXFEnlR6e3ULTttrVUkeJbZTST3UeFapBlY232i4XBG+5+qtthjbxcHcjBCSq8=
X-Received: by 2002:a50:cc87:0:b0:557:15d:b784 with SMTP id
 q7-20020a50cc87000000b00557015db784mr1775edi.2.1704741223938; Mon, 08 Jan
 2024 11:13:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214230850.379863-14-rdbabiera@google.com>
 <20231214230850.379863-19-rdbabiera@google.com> <ZYGjmryUR7m2Q9yw@kuha.fi.intel.com>
In-Reply-To: <ZYGjmryUR7m2Q9yw@kuha.fi.intel.com>
From: RD Babiera <rdbabiera@google.com>
Date: Mon, 8 Jan 2024 11:13:32 -0800
Message-ID: <CALzBnUH6Zb+yx-ri39bPOoTydNcQZOc3Vwo32xLxtS_dESBWGQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] usb: typec: tcpm: process receive and
 transmission of sop' messages
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, badhri@google.com, 
	bryan.odonoghue@linaro.org, agross@kernel.org, andersson@kernel.org, 
	konrad.dybcio@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 6:07=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> Why not just fall through?
>
>         case TCPC_TX_SOP:
>         default:
>                 negotiated_rev =3D port->negotiated_rev;
>                 break;
>

Will do, thanks for the advice!

best,
rd

