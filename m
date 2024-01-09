Return-Path: <linux-kernel+bounces-21192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF4A828B8B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41811C24969
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8702D3C070;
	Tue,  9 Jan 2024 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMT42gRL"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1AF3BB53;
	Tue,  9 Jan 2024 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ccea11b6bbso30559701fa.0;
        Tue, 09 Jan 2024 09:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704822849; x=1705427649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIbyrPSKsQbDcDQfXkpDHHC7/9eaZRTzW2YiXQnsBHA=;
        b=XMT42gRLyyTFYpjM96K12626QWAiAgXekewyZ2Jogf88gRAu9OYhWNTyK3aocMFiU1
         T1tqYO9cUXBq0LrtsSG97sqhw62W9HROwsvdATzbLzAZkdJDpTnGf1Hn7iQ0YNx6B/DB
         9sjASChdO0ra8pXyOhQrwSOChdgCVzbyylzGNKv4aOZDdMw9bDRYQhzyYKYvQbEYxE3o
         VZmDvISrYNtoLCXPPMdKGJg8uMMBe7KVRHYjlyYd6tGrf/UJmvyaJy8dMknEZO1FVF+h
         TwBtD+C4+xD7JX591zgqwnH5OYiHQQ0oeJjQdHsKVR8k7SB9q2uPU7YyfDUseu1Kf/6m
         1nXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704822849; x=1705427649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIbyrPSKsQbDcDQfXkpDHHC7/9eaZRTzW2YiXQnsBHA=;
        b=OwkjTJv90kQbpFiX+a6dYAMwPBoCcbsbVey4r7yn0rh8pDhq1XrT2OLOquNmZRVVg1
         EJ9Le1naKUmRqRpW2xqP4wyAdm7ivA3HTvRmccyCfueZYEw5xmEICvUZtbeJNnraR5Wn
         pwXwZnzojOQKyzH82OP0zfaBLaqfKMrqb1AexD+uQInK6Ja9wDbi1Pa8+6xHMEeaWfvj
         wVcMrZTf2F9BXb0f3jfo1qFs7meEiSmkpz8MzzcvUq9YgPLEUtdypePYNPOYEK9qCe4g
         uuMXHDJqCkDFhydOshLTATlynKTdDO1KIiEEP43o8zQhtD5l7EWyE4z3PvKFuMzEvNIQ
         d/7g==
X-Gm-Message-State: AOJu0YztWfbquwU8kwdOa6ivSTG3CptSKAmL/SlkE3Rcl9EiLTEM3DLo
	fVwtcUcYIRXFUIaV8N2lcRx/EKwbBppilV5yXhs=
X-Google-Smtp-Source: AGHT+IEAquitmm4I7dlVh6YzzaFvZ4MIqaJQdk5o3aYdijgf7VIyZgpHMCQj8qGGmTYobON22fBPCxUBWMEY6+X144o=
X-Received: by 2002:a2e:9606:0:b0:2cc:78b7:1ef0 with SMTP id
 v6-20020a2e9606000000b002cc78b71ef0mr738949ljh.4.1704822849013; Tue, 09 Jan
 2024 09:54:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108224614.56900-1-verdre@v0yd.nl>
In-Reply-To: <20240108224614.56900-1-verdre@v0yd.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 9 Jan 2024 12:53:56 -0500
Message-ID: <CABBYNZKV176teECGnGKTCNNo45ZYbCRs=YddETOUMUsJQX5PdA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Bluetooth: Improve retrying of connection attempts
To: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Mon, Jan 8, 2024 at 5:46=E2=80=AFPM Jonas Dre=C3=9Fler <verdre@v0yd.nl> =
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
> v3:
>   - Move the new sync function to hci_sync.c as requested by review
>   - Abort connection on failure using hci_abort_conn_sync() instead of
>     hci_abort_conn()
>   - Make the last commit message a bit more precise regarding the meaning
>     of BT_CONNECT2 state
>
> Jonas Dre=C3=9Fler (4):
>   Bluetooth: Remove superfluous call to hci_conn_check_pending()
>   Bluetooth: hci_event: Use HCI error defines instead of magic values
>   Bluetooth: hci_conn: Only do ACL connections sequentially
>   Bluetooth: Remove pending ACL connection attempts
>
>  include/net/bluetooth/hci.h      |  3 ++
>  include/net/bluetooth/hci_core.h |  1 -
>  include/net/bluetooth/hci_sync.h |  3 ++
>  net/bluetooth/hci_conn.c         | 83 +++-----------------------------
>  net/bluetooth/hci_event.c        | 29 +++--------
>  net/bluetooth/hci_sync.c         | 72 +++++++++++++++++++++++++++
>  6 files changed, 93 insertions(+), 98 deletions(-)
>
> --
> 2.43.0

After rebasing and fixing a little bit here and there, see v4, looks
like this changes is affecting the following mgmt-tester -s "Pair
Device - Power off 1":

Pair Device - Power off 1 - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001bfff
    Current settings: 0x00000080
    Class: 0x000000
    Name:
    Short name:
  Mesh feature is enabled
Pair Device - Power off 1 - setup
  Setup sending Set Bondable (0x0009)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Pair Device - Power off 1 - setup complete
Pair Device - Power off 1 - run
  Sending Pair Device (0x0019)
Bluetooth: hci0: command 0x0405 tx timeout
Bluetooth: hci0: command 0x0408 tx timeout
  Test condition added, total 1
Pair Device - Power off 1 - test timed out
  Pair Device (0x0019): Disconnected (0x0e)
Pair Device - Power off 1 - test not run
Pair Device - Power off 1 - teardown
Pair Device - Power off 1 - teardown
  Index Removed callback
    Index: 0x0000
Pair Device - Power off 1 - teardown complete
Pair Device - Power off 1 - done

--=20
Luiz Augusto von Dentz

