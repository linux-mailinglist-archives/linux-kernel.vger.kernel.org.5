Return-Path: <linux-kernel+bounces-20002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309DB827813
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4305E1C22C1A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F4C54F83;
	Mon,  8 Jan 2024 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3VatbUTs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B4354F8A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-557bbcaa4c0so1277a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 11:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704740576; x=1705345376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJHwZDY9S/pUm0bz+X6WG507t3jYQ5Spq8C9eSzA1l8=;
        b=3VatbUTssMUq+ff7dkUxY23vECALV2ulyJ5C0aOYhbc2QRyVqZ+MvDlmt/hYMF3DON
         jP+oTmIMmgDmpJ6Ky1aHsWrsuUkbUS+vBUk4Sc/7rxy5qW1X5Et5fNSrMVTjBFZKFZ5C
         YsxEcKKXvyAPtRG6NkT2VsJUb6//D9NcaNrNpAIYSZonhONnoqzmFrClpP2miq9pux1B
         jJLFS7YLB8wjXJgJq5hEZdc44wJuDJ7cb5DOrYs6igEqxP5D9p3RnzjwSKuATUKsYLmJ
         mKNYBiQsSU6vqFRDWBhY7+F7eLKR1xMEAIJZOj6Dfa2fbfHNd2emhUYWBnsFg+XuOBjj
         9GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704740576; x=1705345376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJHwZDY9S/pUm0bz+X6WG507t3jYQ5Spq8C9eSzA1l8=;
        b=Y38hoTX7viQzAxmKKNSCTcCBFF5AATArgLLCkHDhGEdWr5J2ICB85Y4vI/tdcoB+Mf
         8sUBD6UamR6HMQxCVkQZuqtahH2y2E99Lm4dp5eC4nX8d6ZRRtaOnaW+Cy/5bLBhNqhz
         ab9dXU1TnBgGc/nXLuFZY6zy9Gt/uyEyWuYA6uF+1i3GMkV0KIZ57K0pl9dwhOMIRIK4
         dhd9qdV1txe0ZfVms9ROg9fXmWRCSJ6eh5f3J1uEi+ZQ+cPZ2Qf1I2Jry6t5oosSkGsy
         VcUZ4DbZWBZE0tFpFqs2pqMniDvQw/133K1gASnpzoP7W+vhBnGMVQRE8htJIWdTpGHa
         9luA==
X-Gm-Message-State: AOJu0Yz5m07dF/4CaTA2lnNOf2+1FBwPbGLwp/CjROuTdvX52taw9yFb
	KjjcgwonWOjUIxGjENugkVuJ2zX5HYSlFGIUdmOfoW8ZtIYC
X-Google-Smtp-Source: AGHT+IFuJqtqlXqvaMIaC4nKpUc2yLbvb+JIMwYG1OzvM8oUHXWobSdjDlHqoPWblPiztHJZ2SAqoc5dwJ+PIm4IefE=
X-Received: by 2002:a50:d48c:0:b0:557:8cb9:90a1 with SMTP id
 s12-20020a50d48c000000b005578cb990a1mr5219edi.6.1704740576501; Mon, 08 Jan
 2024 11:02:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214230850.379863-14-rdbabiera@google.com>
 <20231214230850.379863-24-rdbabiera@google.com> <ZYGphs1nBu3pnmYd@kuha.fi.intel.com>
In-Reply-To: <ZYGphs1nBu3pnmYd@kuha.fi.intel.com>
From: RD Babiera <rdbabiera@google.com>
Date: Mon, 8 Jan 2024 11:02:45 -0800
Message-ID: <CALzBnUG7tD01jAqyw6=dof7KEdd94+7bXhFhk6bpxo7dRDFnrg@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] usb: typec: tcpm: add discover svids and
 discover modes support for sop'
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, badhri@google.com, 
	bryan.odonoghue@linaro.org, agross@kernel.org, andersson@kernel.org, 
	konrad.dybcio@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I must've replaced the partner unregistration instead of adding the
cable one when
splitting the patchset, sorry about that. Thanks for the catch.

On Tue, Dec 19, 2023 at 6:32=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> I'm probable missing something, but where are the partner altmodes now
> unregistered?
>
> >       memset(modep, 0, sizeof(*modep));
> > +     memset(modep_prime, 0, sizeof(*modep_prime));
> >  }
> >
> >  static void tcpm_set_partner_usb_comm_capable(struct tcpm_port *port, =
bool capable)
>

best,
rd

