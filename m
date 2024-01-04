Return-Path: <linux-kernel+bounces-16737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3173482431B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F22C1C23EBA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003F022339;
	Thu,  4 Jan 2024 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pPNTgmuv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E6D224C1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4b7a3189d47so170773e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 05:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704376249; x=1704981049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wUYo80fdR4FT/SVGApfPe7pPXOeeF8oJCKGkhPUBQ4=;
        b=pPNTgmuvqRFHRfmrinDT6Kmu+XYHwzjLKYwlsZZptz7nSrUtv5ATlLI1RzdC6g3xYo
         caZYZlx2ZSBg4ubL27Gj32ylh+6K+Glqn14M6IgzMEIDX4+BPJEbFRMs0neQTDkSnczk
         qJ56GpohpM3zta5EY1x1q+w8dhaQFkNmiaOzyBR1BZNCpewmsB6uk3c3jqc6C+IS2CiK
         l01HelmzLuh4EgjBBWnSf53rYAhSwGGSsIV4/3AcJnENMWcH+E/nwA/N9w7SDCQzPYfl
         3TPJx4uo4aM1n38KWwUI/CElNQQzUy6x8Gay5Rm/usWxBVfFneY2TpJVqtaNHwFSJ/oA
         xAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704376249; x=1704981049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wUYo80fdR4FT/SVGApfPe7pPXOeeF8oJCKGkhPUBQ4=;
        b=Q6wxCwBQ6BY5H4DKtgcxtdNMqJuYAOaM3rn7V2/Ml49xtQ86FfFTp1caxU2CGHXos3
         SL+Ur9+7dq+M/Vmes2qqOHK3AKbK/tWT1hkyWCAADdGsc5p44QWGXKbX+JfcJ5+bZ6XI
         XH1dkxglWuicA85zTSvB6wYedjxY9tnbssWIki0QCyfp7v3jetnz/JGlqvck9j+0ia19
         CR/k8LFyLiYZ4bwWSSqCx6Te7VsWASaxyrM10qemUulZ9fB1SNHpmn/BtVMX5ZbwJepm
         VlSPOS1f2ghEA+Sx25teYh/6xRlBuK3UG8PdOMoeWgPbV5LQ+Fw2LGRjsi82GUWMghMD
         iAiw==
X-Gm-Message-State: AOJu0YzvhZi3Yvz6Zrzg5P4rdgzM6djcpkJPGMKBQFe+RAVs8l2RiMlh
	h6oMXUT/SjgmZLTdBdc50W3Q1O67kNq04rwZsxZahxciHiEq
X-Google-Smtp-Source: AGHT+IHA/5q3b8vhSx+o+mjSaAttqwGmWpFeQFH52jhXWq3ovLs5SXl+BPsqqepe9tmMzqZ3U02Yht1it0woe5HbOCo=
X-Received: by 2002:a05:6122:30a1:b0:4b7:a77c:d133 with SMTP id
 cd33-20020a05612230a100b004b7a77cd133mr538092vkb.11.1704376248694; Thu, 04
 Jan 2024 05:50:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com>
 <20231216-rb-new-condvar-methods-v2-4-b05ab61e6d5b@google.com> <76415f1d-174c-4cee-9b58-e956be6bda54@gmail.com>
In-Reply-To: <76415f1d-174c-4cee-9b58-e956be6bda54@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Jan 2024 14:50:37 +0100
Message-ID: <CAH5fLgjdk+e419Zir4q59pApeY1XpDWf7m+AC=wUXkNwSkXN-Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] rust: sync: update integer types in CondVar
To: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Tiago Lam <tiagolam@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 5:42=E2=80=AFPM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
> On 12/16/23 12:31, Alice Ryhl wrote:
> >       /// Calls the kernel function to notify the appropriate number of=
 threads with the given flags.
>
> There are no more flags, please update the comment.

Nice catch! Fixed.

Alice

