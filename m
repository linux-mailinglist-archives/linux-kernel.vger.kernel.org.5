Return-Path: <linux-kernel+bounces-133418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8204689A373
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22F14B24976
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176F3171678;
	Fri,  5 Apr 2024 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiYYbD3b"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B032516C854;
	Fri,  5 Apr 2024 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712337734; cv=none; b=ei3SWCbhZdaPQ6UiXImlTTF8vDkscXE5T15FgMqz6ll6u++4AwpKZLdibV6qKIkIQ6qd0TBdrBm/5RCI+yqkIG6MbRdpLzBXwy35bVdzbaDwSfMZzjLMsrpB9core5Is8eg8NvmNfE8I7hS4Y4Kqeq8cwCApJ6yHO4q4aZ6ELwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712337734; c=relaxed/simple;
	bh=n3a9v5YOTVzzqn8EGQ+AL8Oqj4tc98RubfBVQuMg7Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHVo9QG0DQCqE9FfrNLuOf762G20eP2PD9KAOvqzF2iR2SFZmilsUcz0ZK+OYGPLy47eIOUW9RwqClxZ2+SOgWdjCEwV0KmQIgPVVI43bVmueOXmmFfQZNMzdG2cCP89M1V5jVHn3f5HdlCDwrSM8llGuM1hrvO3gCQYQoMYSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiYYbD3b; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d858501412so26533381fa.0;
        Fri, 05 Apr 2024 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712337731; x=1712942531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3a9v5YOTVzzqn8EGQ+AL8Oqj4tc98RubfBVQuMg7Lw=;
        b=KiYYbD3bi5UdtZUCB6BmzisYUHm0VeXTSPi9jFT8rD6FMyW4iC5sqCyS4W4Q9brp1Q
         3IAB3cUwbFa3ltOkQPo5ucXu8DGCgtvSaHR1bCxsROnCe8960NFfj1PlDJlkuhleVAL8
         UNV++ZNaaKPT2cTLSgwaSccLW4WpiZXt62if2AEmhCw9AU8jZ6xDwoqdfk2ZVut1pdgm
         MqZaMOMHUkpL/+NsIRjFA+Oz78nEM1CEZ85pEXzpugdS0ApW8n6HXy/CN5lVOoQHY3FS
         M8nzf1ajw822Gtmda1cVw4+KTdSHSZVA6sCCgyH/xgTrzHc8kKXfFH0cSeYW9luJJFlX
         +nAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712337731; x=1712942531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3a9v5YOTVzzqn8EGQ+AL8Oqj4tc98RubfBVQuMg7Lw=;
        b=oq7uZWd97NGFFDB/5R8zo2omxubKHPfhxmcfFbieTNHKbK1A9nrXksHIbM0IpGjtEx
         bpns8p1hcXSMabwvSV5g4i7kDFWGnQoFImrjpZxjfVimbhwL3oYhJiRIoxoh8P0JMGcI
         uHysTZvWXiVoQmeEg7KJgfbt14+bwfxAePeLzSizTQYb2YaSAyLi1mtS0b3MlzF0WL5a
         4cLwRiQmA/1F4k41dR+ckKn7nCGnSl6qOnlI+oHVETGz404E89MH2oKN23fY11lesl5w
         f7FZDWchoVpKsCGF8XVVjAuEIH7m/PS31I6K2kGL/s0LUU3WfEn+jZjhMSOxdkX2ok6e
         8JKw==
X-Forwarded-Encrypted: i=1; AJvYcCUAoe+jbB+o3IBASYux+T3RkdgG+5+duYvEH/Z0f3K0L+dbdZQqILoEnrrEwPLEu1Xr3F3xlJ51m89WwIJJgRIqvDMU+iyloD/ODWogMeGwY1KQk+KHrFCk6ojZBPNHL0as7u+trER7ag==
X-Gm-Message-State: AOJu0YwEPNhaHtADheu6ZxV6zWUtUTToHkb+wPcVhOLSZpZKbl0y869y
	NL+STkb2JWrVxnRXImE95knVHL+D2mATHg1KyyTmF0Jz7s8BaDw7is19fLKi3+IO+UpeT+gGDt8
	fgptGXkmb+IZudPs8XkOZibCeXdcTEvBem+UgvqDD
X-Google-Smtp-Source: AGHT+IHVWxEB5bg1gMnUoidt4kAlY2qbh0psf71zqBG4OKlkeQSXjPgyyWN5UHVvE2xlj9uZ+5X7c+JgDpEubkWNmOk=
X-Received: by 2002:a2e:a717:0:b0:2d8:71d4:4c62 with SMTP id
 s23-20020a2ea717000000b002d871d44c62mr605492lje.49.1712337730626; Fri, 05 Apr
 2024 10:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404160649.967-1-bavishimithil@gmail.com> <78091796-fd0a-42dd-a4da-f7bed3025bf9@linaro.org>
 <CAGzNGRnuG_gLUrH1N57WvpKbpiNtFrcsG6nJcacQNJB_yMYNrA@mail.gmail.com>
 <ec7f77a7-2cf1-4ea6-b9c4-d4fe8a1673ab@linaro.org> <CAGzNGRktm5gMj=bhtX2RAzcn1v5ref+nV-HV3Fct56FzAzxjWA@mail.gmail.com>
 <c9084453-65f1-43b0-88df-5b73052ccb72@linaro.org>
In-Reply-To: <c9084453-65f1-43b0-88df-5b73052ccb72@linaro.org>
From: Mithil <bavishimithil@gmail.com>
Date: Fri, 5 Apr 2024 22:51:58 +0530
Message-ID: <CAGzNGR=2-us8GRB3RNi4_24QZ9rNBC7Lx0PFsWwbvxuRKk5ngw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: omap-mcpdm: Convert to DT schema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 10:38=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 05/04/2024 18:29, Mithil wrote:
> > On Fri, Apr 5, 2024 at 9:27=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 05/04/2024 16:48, Mithil wrote:
> >>> So sorry about the 2nd patch being sent as a new mail, here is a new
> >>> patch with the changes as suggested
> >>>
> >>>> Please use subject prefixes matching the subsystem
> >>> Changed the patch name to match the folder history.
> >>
> >> Nothing improved. What the history tells you?
> >>
> >
> > Referred to "ASoC: dt-bindings: rt1015: Convert to dtschema"
> > Not really sure what else I should change.
>
> But the subject you wrote here is "dt-bindings: omap-mcpdm: Convert to
> DT schema"?
>
> Where is the ASoC?
>
I did change it, will send the patch again.

>
> reg is not correct. Please point me to files doing that way, so I can
> fix them.
>
> You need items with description.
>
Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
I referred here for the description, but will add items for the 2 regs

> > Interrupts and hwmods use maxItems now.
>
> hwmods lost description, why?
Seems self explanatory.

> > Changed nodename to be generic in example as well.
>
> "mcpdm" does not feel generic. What is mcpdm? Google finds nothing.
> Maybe just "pdm"?
>
Multichannel PDM Controller. Kept it like that since the node is also
called as mcpdm in the devicetree. Calling it pdm might cause
confusion.

Best Regards,
Mithil

