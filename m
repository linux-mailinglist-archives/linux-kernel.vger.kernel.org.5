Return-Path: <linux-kernel+bounces-55687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8B684BFF6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37CA1F25ED5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83BC1C2BE;
	Tue,  6 Feb 2024 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKM/alFT"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715991C288;
	Tue,  6 Feb 2024 22:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258146; cv=none; b=qG1F8TOlLfL5qcTJYdfG+9dC+RadxAWBNNnveWno0H6Smf1sfmKZAboyDxWm68+UKG9vZ0+QuYfiZOvh56HUXwmnUZeaj4YyjcsdOk9kvz0kXeCEl5yVtwI9f1+ETBS03XFZ4PtEsPQouX9bC2nzmAeuTs+Z/qLR6VCGpyvTyHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258146; c=relaxed/simple;
	bh=/+FnYMvjouZxspj71b2aviqm1ZrTgHz4LOr0fdHG2jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFaSNHnSflwBo1RMHScTk+4+myncSGweG6tHUpfHY3HUZF9bdompxvkY5nyYteFDDkNhIePZnqx3BUNXTGU0CB/haZhcyP32ky2jfJkkdT64ujl3EsDsEqXfyUjCCANW43X55oDetzDj5L+fBw6cWQ9PQ6xEJeVEvgRh35aed+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKM/alFT; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d093cb1ef3so49593151fa.3;
        Tue, 06 Feb 2024 14:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707258142; x=1707862942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xL2bLfkb2GNgj7Y6sR0Zd2B01OT964Aq6LJ9qJkJ44=;
        b=bKM/alFTOn0WPop35P4CcSn5vNYuyWI/eSzrHrzzLajDJ2ZNeDi71GIQqpZkFKcmNP
         7YqN6Z72awHsTWmxiLXqW1lsmM2A7v+Tat+mpDcemqdmxuLTeE5CNujIGhWmc7ZrkH0g
         BCHYf/EqSsnSAB0QoHRCc+esg1YhlYXdQrm3loJdTbjJLribpZBHqrH9OJW89Bq+gd3v
         PpsO6Cma8WBsOJoNVFwN+VoqUAUCCSszMxODYqUjkISIjHKwI1KiL8T6e0UCFkgj2Gz0
         AvajxlXnorZQlNt9rZvT/RTV0RUai9K1Tpr7dpGJZfnke0d0bgZcN4lk+jsedO6+Kgca
         EcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707258142; x=1707862942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xL2bLfkb2GNgj7Y6sR0Zd2B01OT964Aq6LJ9qJkJ44=;
        b=tFei79yuZtKskeEQeUt8u+7kgWrrelVQENEVP8WmU6kTMb3H/J1py/8Zar9LLBFqqb
         Fs6WP7GFeX+lwe5hgYHR8hNiZyHN45EvTuw5jj1oqDnTWdGPoFUzTnvJL3zrWXKtXnM7
         kgmOVAxa1EdFGjMMC7az69f1/peHp85OVJ6jL4eDBJ2MYJ8UNJhs5CRPWBl34BFk4dLX
         zZ1XBw0TYPOgz/ObtAkEwIuXz/TesHjDH5BJuhZeFzP8bu3E6WQKENA3ba4jl8N6/Yti
         xTD6IB3x/kC10wnQBWbjz+7veOno/NzjiAVKJtWAwru/scvIZI0Sp1t2Gq1kh06eqOhr
         LXug==
X-Forwarded-Encrypted: i=1; AJvYcCXHxvlntIJ80tIyUG7OXXiEh7G/3zb42IY6rF5+5L+bwi08bcGJU+k/U70wokYpLKfxpEGlRXL0pKBrrAvKmsIDgTTUy61FNzw1qDSgkroV3zeJmwFsh+t+sGT4pPOXpJeqkiA2EieGE0Z6GcStaRcAGWrWb7CbVyvtBW0Q3QB3W6GHzE4C
X-Gm-Message-State: AOJu0YwD/i0NKIPArqSVG/HINmwSCp3YTL0RHo3UXsB7+FjupnGEWCcq
	yUPt2t26cbss17TuV88AREdBhLQXfFtP99j/ip+mDuf7bouJQg/QjaFzfHQQniWPSGWIxu8Kc7n
	Ne+cTRtlJfG+vJWa5f8ECI3R/R/2T7L9rXp0=
X-Google-Smtp-Source: AGHT+IHwaW15HFEQh19pG+tsJYUTRUbl72ZDGAFwpkDKhd2jTUDr4sC8KVbRXCmCRx+c7+NxTrMj5jxjgJwv8qvQ6zE=
X-Received: by 2002:a05:651c:1504:b0:2d0:ae3d:d393 with SMTP id
 e4-20020a05651c150400b002d0ae3dd393mr3455249ljf.1.1707258141325; Tue, 06 Feb
 2024 14:22:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206110816.74995-1-verdre@v0yd.nl>
In-Reply-To: <20240206110816.74995-1-verdre@v0yd.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 6 Feb 2024 17:22:08 -0500
Message-ID: <CABBYNZJgKCeGfL+CngEA2QcVZAtf5yEqiX7ccQsuWVtjZhCvjw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Bluetooth: Improve retrying of connection attempts
To: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Tue, Feb 6, 2024 at 6:08=E2=80=AFAM Jonas Dre=C3=9Fler <verdre@v0yd.nl> =
wrote:
>
> Since commit 4c67bc74f016 ("[Bluetooth] Support concurrent connect
> requests"), the kernel supports trying to connect again in case the
> bluetooth card is busy and fails to connect.
>
> The logic that should handle this became a bit spotty over time, and also
> cards these days appear to fail with more errors than just "Command
> Disallowed".
>
> This series refactores the handling of concurrent connection requests
> by serializing all "Create Connection" commands for ACL connections
> similar to how we do it for LE connections.
>
> ---
>
> v1: https://lore.kernel.org/linux-bluetooth/20240102185933.64179-1-verdre=
@v0yd.nl/
> v2: https://lore.kernel.org/linux-bluetooth/20240108183938.468426-1-verdr=
e@v0yd.nl/
> v3: https://lore.kernel.org/linux-bluetooth/20240108224614.56900-1-verdre=
@v0yd.nl/
> v4:
>   - Removed first two commits since they are already applied
>   - Removed a BT_DBG() message in the acl_create_connection() function
>     while moving to hci_sync because it seemed out of place in hci_sync
>   - Added a mention of the test failure in mgmt-tester to commit message
>
> Jonas Dre=C3=9Fler (2):
>   Bluetooth: hci_conn: Only do ACL connections sequentially
>   Bluetooth: Remove pending ACL connection attempts
>
>  include/net/bluetooth/hci.h      |  1 +
>  include/net/bluetooth/hci_core.h |  1 -
>  include/net/bluetooth/hci_sync.h |  3 ++
>  net/bluetooth/hci_conn.c         | 83 +++-----------------------------
>  net/bluetooth/hci_event.c        | 21 ++------
>  net/bluetooth/hci_sync.c         | 70 +++++++++++++++++++++++++++
>  6 files changed, 86 insertions(+), 93 deletions(-)
>
> --
> 2.43.0


Doesn't seem to work with the new test:

Sequential connect - setup complete
Sequential connect - run
  Create connection finished
  Connect failed for Pair Device
  Create connection finished
Sequential connect - test timed out
Sequential connect - teardown

--=20
Luiz Augusto von Dentz

