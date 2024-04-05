Return-Path: <linux-kernel+bounces-133043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA16899DFE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06F71C20B09
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C116C16D4F2;
	Fri,  5 Apr 2024 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC4pqoIf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA0615FD16;
	Fri,  5 Apr 2024 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322436; cv=none; b=EtsigSoXaB28Fx4hdrWFruCprocKVRJtrJurqXgLrBHC1lpo1IV4hG8UNP1XlgsQdA9xwVR17S+15a+aK1m2pD/Fa8qu7HF4R8+msbO9ZAEHlC+wCuBouDgakTrlem0MsB4BMFRa5eZiim6mgZng4q+qYvFrUCZac+khuvn+xA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322436; c=relaxed/simple;
	bh=S6rcliy68N/x8sdVc9sO6lbozNQnQoSf0/uWIMJWqog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UlCHUPIqGqwsTmJIn7N/4qOeGK8QCAthBOuS/Xo0QSwJYr21i7zqH5mvS0ItOD+9V99V/ycH1bg6Ci/TJO0M4jr+AGlvvCgnr4jM6QWSx8Xat3w8GGAwJW9uUQjONl0x78uRUEEuEBzF9RIk+8yjPY/wekWLi6kd/6RdjahNd/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC4pqoIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6237FC433C7;
	Fri,  5 Apr 2024 13:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712322436;
	bh=S6rcliy68N/x8sdVc9sO6lbozNQnQoSf0/uWIMJWqog=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BC4pqoIf464XB7an62drpauJbcijrXYMkYjFWwX51iURRmC241Deexc0gQdPwvouO
	 EoH2txrdcRkwsADMWlS0S2uNqjHewQkysdHbU/8nhCLTrqZS4iayT9TvcatD6HAyuZ
	 HP7p0gQ3MqJJ5Za0GMQ8ufYOQ8KLAg0JDY6bgI/CVY/s178embEisJy7Nowyugfyjm
	 QuM3R6eeClplWVtPXQOU4Xo729XrDw20cKNfLC2Yr+8PnPyABCKcYKABq5zoaEfiJG
	 6CtjQutLExDir153v1XmpsncFgTBdretxBMJBQbKfg4RP7ATbL74WXNRXKu3ey7aUd
	 VupGPCn0jixiw==
Message-ID: <8ce4c1d8-e379-4fe0-ae31-ba5bdf4c1e06@kernel.org>
Date: Fri, 5 Apr 2024 22:07:04 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v7 14/37] clk: Compatible with narrow registers
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Lee Jones <lee@kernel.org>, Helge Deller <deller@gmx.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Shawn Guo <shawnguo@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck
 <linux@roeck-us.net>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Javier Martinez Canillas <javierm@redhat.com>, Guo Ren <guoren@kernel.org>,
 Azeem Shaikh <azeemshaikh38@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Jacky Huang <ychuang3@nuvoton.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 Anup Patel <apatel@ventanamicro.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Sam Ravnborg <sam@ravnborg.org>, Sergey Shtylyov <s.shtylyov@omp.ru>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-fbdev@vger.kernel.org
References: <cover.1712207606.git.ysato@users.sourceforge.jp>
 <9c1d56d37f5d3780d3c506ae680133b6bdaa5fdc.1712207606.git.ysato@users.sourceforge.jp>
 <CAMuHMdVXvPW+3-sY2XPQ2aMcTZkK9zoMnxWeZ+PRB+VRgGszdQ@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CAMuHMdVXvPW+3-sY2XPQ2aMcTZkK9zoMnxWeZ+PRB+VRgGszdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/5/24 21:56, Geert Uytterhoeven wrote:
> Hi Sato-san,
> 
> On Thu, Apr 4, 2024 at 7:15 AM Yoshinori Sato
> <ysato@users.sourceforge.jp> wrote:
>> divider and gate only support 32-bit registers.
>> Older hardware uses narrower registers, so I want to be able to handle
>> 8-bit and 16-bit wide registers.
>>
>> Seven clk_divider flags are used, and if I add flags for 8bit access and
>> 16bit access, 8bit will not be enough, so I expanded it to u16.
>>
>> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> 
> Thanks for the update!
> 
>> --- a/drivers/clk/clk-divider.c
>> +++ b/drivers/clk/clk-divider.c
>> @@ -26,20 +26,38 @@
>>   * parent - fixed parent.  No clk_set_parent support
>>   */
>>
>> -static inline u32 clk_div_readl(struct clk_divider *divider)
>> -{
>> -       if (divider->flags & CLK_DIVIDER_BIG_ENDIAN)
>> -               return ioread32be(divider->reg);
>> -
>> -       return readl(divider->reg);
>> +static inline u32 clk_div_read(struct clk_divider *divider)
>> +{
>> +       if (divider->flags & CLK_DIVIDER_REG_8BIT)
> 
> When you need curly braces in one branch of an if/else statement,
> please use curly braces in all branches (everywhere).
> 
>> +               return readb(divider->reg);
>> +       else if (divider->flags & CLK_DIVIDER_REG_16BIT) {

And no need for an else after a return...


>> +               if (divider->flags & CLK_DIVIDER_BIG_ENDIAN)
>> +                       return ioread16be(divider->reg);
>> +               else

and here.

>> +                       return readw(divider->reg);
>> +       } else {
>> +               if (divider->flags & CLK_DIVIDER_BIG_ENDIAN)
>> +                       return ioread32be(divider->reg);
>> +               else

here too.

>> +                       return readl(divider->reg);
>> +       }
>>  }
> 
>> --- a/drivers/clk/clk-gate.c
>> +++ b/drivers/clk/clk-gate.c
> 
>> @@ -137,12 +155,30 @@ struct clk_hw *__clk_hw_register_gate(struct device *dev,
>>         struct clk_init_data init = {};
>>         int ret = -EINVAL;
>>
>> +       /* validate register size option and bit_idx */
>>         if (clk_gate_flags & CLK_GATE_HIWORD_MASK) {
>>                 if (bit_idx > 15) {
>>                         pr_err("gate bit exceeds LOWORD field\n");
>>                         return ERR_PTR(-EINVAL);
>>                 }
>>         }
>> +       if (clk_gate_flags & CLK_GATE_REG_16BIT) {
>> +               if (bit_idx > 15) {
>> +                       pr_err("gate bit exceeds 16 bits\n");
>> +                       return ERR_PTR(-EINVAL);
>> +               }
>> +       }
>> +       if (clk_gate_flags & CLK_GATE_REG_8BIT) {
>> +               if (bit_idx > 7) {
>> +                       pr_err("gate bit exceeds 8 bits\n");
>> +                       return ERR_PTR(-EINVAL);
>> +               }
>> +       }
>> +       if ((clk_gate_flags & CLK_GATE_HIWORD_MASK) &&
> 
> If you use parentheses around "a & b" here...
> 
>> +           clk_gate_flags & (CLK_GATE_REG_8BIT | CLK_GATE_REG_16BIT)) {
> 
> please add parentheses here, too.
> 
>> +               pr_err("HIWORD_MASK required 32-bit register\n");
>> +               return ERR_PTR(-EINVAL);
>> +       }
>>
>>         /* allocate the gate */
>>         gate = kzalloc(sizeof(*gate), GFP_KERNEL);
>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>> index 4a537260f655..eaa6ff1d0b2e 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
>> @@ -508,12 +508,16 @@ void of_fixed_clk_setup(struct device_node *np);
>>   * CLK_GATE_BIG_ENDIAN - by default little endian register accesses are used for
>>   *     the gate register.  Setting this flag makes the register accesses big
>>   *     endian.
>> + * CLK_GATE_REG_8BIT - by default 32bit register accesses are used for
>> + *     the gate register.  Setting this flag makes the register accesses 8bit.
>> + * CLK_GATE_REG_16BIT - by default 32bit register accesses are used for
>> + *     the gate register.  Setting this flag makes the register accesses 16bit.
>>   */
>>  struct clk_gate {
>>         struct clk_hw hw;
>>         void __iomem    *reg;
>>         u8              bit_idx;
>> -       u8              flags;
>> +       u32             flags;
> 
> (from my comments on v6)
> There is no need to increase the size of the flags field for the gate clock.
> 
> 
>>         spinlock_t      *lock;
>>  };
>>
> 
>> @@ -675,13 +681,17 @@ struct clk_div_table {
>>   * CLK_DIVIDER_BIG_ENDIAN - By default little endian register accesses are used
>>   *     for the divider register.  Setting this flag makes the register accesses
>>   *     big endian.
>> + * CLK_DIVIDER_REG_8BIT - by default 32bit register accesses are used for
>> + *     the gate register.  Setting this flag makes the register accesses 8bit.
>> + * CLK_DIVIDER_REG_16BIT - by default 32bit register accesses are used for
>> + *     the gate register.  Setting this flag makes the register accesses 16bit.
>>   */
>>  struct clk_divider {
>>         struct clk_hw   hw;
>>         void __iomem    *reg;
>>         u8              shift;
>>         u8              width;
>> -       u8              flags;
>> +       u16             flags;
>>         const struct clk_div_table      *table;
>>         spinlock_t      *lock;
>>  };
> 
>> @@ -726,18 +738,18 @@ struct clk_hw *__clk_hw_register_divider(struct device *dev,
>>                 struct device_node *np, const char *name,
>>                 const char *parent_name, const struct clk_hw *parent_hw,
>>                 const struct clk_parent_data *parent_data, unsigned long flags,
>> -               void __iomem *reg, u8 shift, u8 width, u8 clk_divider_flags,
>> +               void __iomem *reg, u8 shift, u8 width, u32 clk_divider_flags,
> 
> "u16 clk_divider_flags", to match clk_divider.flags.
> 
>>                 const struct clk_div_table *table, spinlock_t *lock);
>>  struct clk_hw *__devm_clk_hw_register_divider(struct device *dev,
>>                 struct device_node *np, const char *name,
>>                 const char *parent_name, const struct clk_hw *parent_hw,
>>                 const struct clk_parent_data *parent_data, unsigned long flags,
>> -               void __iomem *reg, u8 shift, u8 width, u8 clk_divider_flags,
>> +               void __iomem *reg, u8 shift, u8 width, u32 clk_divider_flags,
> 
> Likewise.
> 
>>                 const struct clk_div_table *table, spinlock_t *lock);
>>  struct clk *clk_register_divider_table(struct device *dev, const char *name,
>>                 const char *parent_name, unsigned long flags,
>>                 void __iomem *reg, u8 shift, u8 width,
>> -               u8 clk_divider_flags, const struct clk_div_table *table,
>> +               u32 clk_divider_flags, const struct clk_div_table *table,
> 
> Likewise.
> 
>>                 spinlock_t *lock);
>>  /**
>>   * clk_register_divider - register a divider clock with the clock framework
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

-- 
Damien Le Moal
Western Digital Research


