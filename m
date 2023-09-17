Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A747A3697
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 18:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjIQQhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 12:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjIQQhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 12:37:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C34ED;
        Sun, 17 Sep 2023 09:37:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2TFewphcA0DBhBpc53ea8+WYlyq+sEDPmMQmWezfzluJDEAyBzg4ZM9pvSfnm5aXCaFPZCHpPeN5dZB+Q1JMggerKG0iDa5tHbZsI9aPH7GkBj/MvSOCUwTNRemid0F+jIFoSDnUW/q2WJJ3Arrwijy945baLjKOmUwCVAamsvvP6FoXVz3WcnmgBK2wa74XDDAPgZ+AHZE2cp2weGxFdtiOQMmjDn4R5GhvcxgjWbQWNT5R9yzTGtFEZnYNS6UP19lFpaLwfKosVTiq+0j2qlDA+kB5WPKXnjthUflvdLaN1h5HKn+krXZ2S4optAL4bLh48Xyk+JTcRMkSm9vGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FzEBNhbIHF2D+2hQ8fUiiiJ2snLRjjqtaW1p4zzwpU=;
 b=eqJCTzwa5zve7OusnmVDns4LUWXnn4O1Ml6Y4HF4fwzyPj2lMvQOdIRQ0qqrJxPKNXLQkhlMI8tUrKCJsTE1kgcWEXvMnQ3ApPECNvrt3+RMIz8rKFqn8GIkfJeYTSNXf7Xkc9wi9puRzuZORdzFAtH+CGjDnufBGFLpNnCwSDSERzwRk3TTyXFcvJEyIcwYrWj0W6bnw6ZYmeTNFncd0YGFJKnkckkO1IvFtBIBwvZpOLqhFknFb4MJIE7bVkbRiArbEXvXsOHFewaBRTRE2WQPTLV6jotmmN8M9u2Qg8xGQZKze1DqTUnk2itCyvOlrqqQfxgWQdlanwOs2Cy6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FzEBNhbIHF2D+2hQ8fUiiiJ2snLRjjqtaW1p4zzwpU=;
 b=SuhrxelRULBElOF8Q8Cyqg5TbOOvalWIe6VdfhI4fT9f2XAtW9Yho/VHiDZBuGQZ0b1zRbhCDEZSu7j6RFcrnvWK+rY1aETnNUQyj3TKsvJSqa+TAKM9xU/HyFE4zjEKHXX0r1FeKC/1tvlwfqMWlBCaExbjiTWlltvTa2fXf4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SJ0PR08MB7720.namprd08.prod.outlook.com
 (2603:10b6:a03:3d8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Sun, 17 Sep
 2023 16:37:26 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::946:aafe:294d:b6bb]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::946:aafe:294d:b6bb%2]) with mapi id 15.20.6792.024; Sun, 17 Sep 2023
 16:37:26 +0000
Date:   Sun, 17 Sep 2023 11:37:20 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     stephan@gerhold.net, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
        jonathan.albrieux@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, rydberg@bitmath.org
Subject: Re: [PATCH 2/2] Input: add Himax HX852x(ES) touchscreen driver
Message-ID: <ZQcrQIfXYCv5aMK7@nixie71>
References: <20230913-hx852x-v1-0-9c1ebff536eb@gerhold.net>
 <20230913-hx852x-v1-2-9c1ebff536eb@gerhold.net>
 <abf36591-3b3c-dc47-b1aa-e574325499f4@wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abf36591-3b3c-dc47-b1aa-e574325499f4@wanadoo.fr>
X-ClientProxiedBy: SN7PR04CA0174.namprd04.prod.outlook.com
 (2603:10b6:806:125::29) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SJ0PR08MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c5bc6e-4c94-4f9b-9edd-08dbb79c6010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FDW8v3I0XmO3qAgPa3Ku0eGOF85RfThA7r59k7mGRpa9ei8XdIeAH8vNxrbJk9yhKnO6JT73/Axzb8oYHXQ3LFxwOYLl8O+r1C5jcWXkMz2ilKSi5maQh82hmJfQLuefRJODqs0+2HUrA0j3aD3Z9HC9t9d34GbxSosXazGCHcElP2C/Ivm17PEeZp+h9MUXpJUQof6qwQf0BVCS1U58rZ5nIEYu7Ka2/j+9vfiguLr76d3zz9hkmHMGRlVnyY2YaIggduRjpd/ak/Gw0SitO4hZn4Vyd1UJRiCt384SM+ppd1znthaKYwlFY9ZIjj2xhGSIbAhwyDsyKirsfoA6t6etsRsw1qkP6dRoZkXn1lJBCGo+JDCbHroO8UAFvROBQRvgTJD/ZjCbPFbYMj4ITnrWvrHHFEhUB9oLh/Uk08n/1R6Bhu0d9KC+L5ZCpZDiKHin6V3aJgvtstYHSj1FfKNN5TN17ZbUcSLe1kOe6X0IoZKLLXC3rl6Fazw8HuzTJ35qZH9wlH/YUcC2pgJgLCxHN2RYH/Gbyj3PIglI1GoKoNyARnLAevO2DY8m2WWx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39830400003)(346002)(396003)(376002)(366004)(136003)(186009)(1800799009)(451199024)(33716001)(2906002)(7416002)(5660300002)(4326008)(8936002)(8676002)(26005)(41300700001)(6916009)(316002)(66476007)(66946007)(66556008)(478600001)(6666004)(6486002)(6506007)(83380400001)(6512007)(9686003)(38100700002)(66574015)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?RdyO0cV2OHA+xQhicKytqik0fpk7ecB0mDE2f0U8bjUW05tDkO+nksYvfn?=
 =?iso-8859-1?Q?4WR3KUXyUbmhtD63dMo8gJYvtdRJ8McykQWLyoabpcms5fxzKAJe/EC7eq?=
 =?iso-8859-1?Q?RTpAbYdfmnyVnY782NluLqOg1s3rXGGAGO0vrg0LlZpAyt1Op9Gu5uHAva?=
 =?iso-8859-1?Q?iaZHL1SfSg/YwVk41ZDypOVXdwD4rgjdHeP17ljFW8Z/w5ZSBuCXJ4Rs1X?=
 =?iso-8859-1?Q?as1UKBLI0CoPQBGCnY37nv3VdQWsTnFGP2R/pdbHrRSHoSCS5mCZGgwzUl?=
 =?iso-8859-1?Q?xKc0/nuW8OHgr9mt5mWKpokgJ/Q9ZBeXTaLSg8ndM9EQOlap4gspv38U5v?=
 =?iso-8859-1?Q?PD3mFX6s0SxGpl+YebRI11nPBHVT52K30lI1y400VaHU+ZGI5AiRRHc16N?=
 =?iso-8859-1?Q?I9f4mbVVQM3vit98cgelTHX2bRBhg6IJJyytPetyFeoL9qQPJhGxGjObPd?=
 =?iso-8859-1?Q?10SlhdmZbMJzBIjDexK3sRj9NamDQQtHgQ8PzL/Gig4x/5tX3by5JZ/Xnl?=
 =?iso-8859-1?Q?Ewf26PNTnoZBlR94JOsVwnSbhOix0xkGUI2jolpZG8QJd3fOeh99jpOgwf?=
 =?iso-8859-1?Q?ncmIA75mEvv6VA7BjIEcZNQuAqK/vz+mbEw0HTdyredRgA/Q5t65sXP1ch?=
 =?iso-8859-1?Q?VXe4/gjObNqdEBQ6BmMubeiLBjqI2MuR1xo5I1GlrdqnYocdkbukybZlb3?=
 =?iso-8859-1?Q?Lv23DbNPEzJBsnTthLKN+BMjlDdWdJT8QUXS2xQeZZyBwYT3JofEXtUJJ5?=
 =?iso-8859-1?Q?qzNUrfP9w9HpaX7y20quRPhUriirK6XrjKKAs6x+VUwCoDcROEcuuJx5aa?=
 =?iso-8859-1?Q?m8Q/hHlspo8GSodu2RLuvLMWMYcB570oGJygkmjJTJ2UcBUozuhSK1kDsz?=
 =?iso-8859-1?Q?X0msJLEWKGZVa645zOsrJqGgI2EZEYYV1ZXuME//RLI6hDdbSoShMWrGIq?=
 =?iso-8859-1?Q?5JD95eHTESED/ai8nRgzjvswIcEJcI+jqfijTSauV6r4Ucjv0Z3068v3yE?=
 =?iso-8859-1?Q?jYUCu2uKoIy92/QnWndwJEB+FK1lQWlEBnpmBo6ggv/z16cFEzTAhe9+Sh?=
 =?iso-8859-1?Q?g3TluvoBslUaBNGb49B7Q4AoKkpWTIujHa2myIrqhEalEeA3xFTTmeMRpE?=
 =?iso-8859-1?Q?/j4vhjKeVdKv60i83W7+Qxd59roeGeDtvK44RmBevtDSDLWtqKFxZJC8Uw?=
 =?iso-8859-1?Q?3AaqSbppLofDZehMa065beEoPqWL0zpSAfV6bMcpnlTUbtER8HShf1JTA6?=
 =?iso-8859-1?Q?L61rbm4h1bdY+09uCtG5IpPF1pPvZyb8AGzBgKcTQLlqbiYU4n3z3nEigL?=
 =?iso-8859-1?Q?vy9BAD8nZHBjSotdNzPvU7h177RauMtdwVgjd+7Jbu5Al6B1paJ6zwbmhy?=
 =?iso-8859-1?Q?6byIVpDo7uPWC3KwW/9VZtfDYbpC3fqE8qMH55Vy3rEsvv8kliHK/5WZJZ?=
 =?iso-8859-1?Q?ykrDHbnEKxxdnvF8V5jU8Z74mnEdfMblbflmkBjnWh4rz63xPA+2COnQQp?=
 =?iso-8859-1?Q?9sNF6kg2ipy4FILFGc38rjEs/IHGfT6xH1E+8/TzQX2K5xBhPSyMjf3xPa?=
 =?iso-8859-1?Q?Ylv4BgFFc7aT53GYFBqS+RnT/wOGmxqPSkQI5Cmj7QHvktbzC3xO2Y/mtO?=
 =?iso-8859-1?Q?oqRvFdhJlUE3jqoAmgt/l3Wef2BkwgZFTV?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c5bc6e-4c94-4f9b-9edd-08dbb79c6010
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2023 16:37:25.9543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NeIQylJoFQZxVALN8nVGIR/nJAtITFzgyR9GeNIHt1EBDdEj8eDHk8K/VLzQWllU05XVgcp7UhRm0YvG51bjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB7720
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Sun, Sep 17, 2023 at 08:03:48AM +0200, Christophe JAILLET wrote:
> Le 13/09/2023 à 15:25, Stephan Gerhold a écrit :
> > From: Jonathan Albrieux <jonathan.albrieux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > 
> > Add a simple driver for the Himax HX852x(ES) touch panel controller,
> > with support for multi-touch and capacitive touch keys.
> > 
> > The driver is somewhat based on sample code from Himax. However, that
> > code was so extremely confusing that we spent a significant amount of
> > time just trying to understand the packet format and register commands.
> > In this driver they are described with clean structs and defines rather
> > than lots of magic numbers and offset calculations.
> > 
> > Signed-off-by: Jonathan Albrieux <jonathan.albrieux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Co-developed-by: Stephan Gerhold <stephan-3XONVrnlUWDR7s880joybQ@public.gmane.org>
> > Signed-off-by: Stephan Gerhold <stephan-3XONVrnlUWDR7s880joybQ@public.gmane.org>
> > ---
> 
> ...
> 
> > +static irqreturn_t hx852x_interrupt(int irq, void *ptr)
> > +{
> > +	struct hx852x *hx = ptr;
> > +	int error;
> > +
> > +	error = hx852x_handle_events(hx);
> > +	if (error) {
> > +		dev_err(&hx->client->dev, "failed to handle events: %d\n", error);
> 
> Should dev_err_ratelimited() be preferred?
> 
> > +		return IRQ_NONE;
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> 
> ...
> 
> > +static int hx852x_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct hx852x *hx;
> > +	int error, i;
> 
> Nit: err or ret is shorter and maybe more "standard".

For what it's worth, 'error' tends to be more common in input.

> 
> > +
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
> > +				     I2C_FUNC_SMBUS_WRITE_BYTE |
> > +				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> > +				     I2C_FUNC_SMBUS_WRITE_WORD_DATA)) {
> > +		dev_err(dev, "not all i2c functionality supported\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	hx = devm_kzalloc(dev, sizeof(*hx), GFP_KERNEL);
> > +	if (!hx)
> > +		return -ENOMEM;
> > +
> > +	hx->client = client;
> > +	hx->input_dev = devm_input_allocate_device(dev);
> > +	if (!hx->input_dev)
> > +		return -ENOMEM;
> > +
> > +	hx->input_dev->name = "Himax HX852x";
> > +	hx->input_dev->id.bustype = BUS_I2C;
> > +	hx->input_dev->open = hx852x_input_open;
> > +	hx->input_dev->close = hx852x_input_close;
> > +
> > +	i2c_set_clientdata(client, hx);
> > +	input_set_drvdata(hx->input_dev, hx);
> > +
> > +	hx->supplies[0].supply = "vcca";
> > +	hx->supplies[1].supply = "vccd";
> > +	error = devm_regulator_bulk_get(dev, ARRAY_SIZE(hx->supplies), hx->supplies);
> > +	if (error < 0)
> > +		return dev_err_probe(dev, error, "failed to get regulators");
> > +
> > +	hx->reset_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(hx->reset_gpiod))
> > +		return dev_err_probe(dev, error, "failed to get reset gpio");
> > +
> > +	error = devm_request_threaded_irq(dev, client->irq, NULL, hx852x_interrupt,
> > +					  IRQF_ONESHOT | IRQF_NO_AUTOEN, NULL, hx);
> > +	if (error) {
> > +		dev_err(dev, "failed to request irq %d: %d\n", client->irq, error);
> 
> dev_err_probe() could be used to be consistent with above code.
> Same for below dev_err() calls.
> 
> > +		return error;
> > +	}
> > +
> > +	error = hx852x_read_config(hx);
> > +	if (error)
> > +		return error;
> > +
> > +	input_set_capability(hx->input_dev, EV_ABS, ABS_MT_POSITION_X);
> > +	input_set_capability(hx->input_dev, EV_ABS, ABS_MT_POSITION_Y);
> > +	input_set_abs_params(hx->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> > +
> > +	touchscreen_parse_properties(hx->input_dev, true, &hx->props);
> > +	error = hx852x_parse_properties(hx);
> > +	if (error)
> > +		return error;
> > +
> > +	hx->input_dev->keycode = hx->keycodes;
> > +	hx->input_dev->keycodemax = hx->keycount;
> > +	hx->input_dev->keycodesize = sizeof(hx->keycodes[0]);
> > +	for (i = 0; i < hx->keycount; i++)
> > +		input_set_capability(hx->input_dev, EV_KEY, hx->keycodes[i]);
> > +
> > +	error = input_mt_init_slots(hx->input_dev, hx->max_fingers,
> > +				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> > +	if (error) {
> > +		dev_err(dev, "failed to init MT slots: %d\n", error);
> > +		return error;
> > +	}
> > +
> > +	error = input_register_device(hx->input_dev);
> > +	if (error) {
> 
> input_mt_destroy_slots() should be called here, or in an error handling path
> below, or via a devm_add_action_or_reset().

This seems like a memory leak in every touchscreen driver; maybe it is more
practical to have the input core handle this clean-up.

Other drivers can and do insert other return paths between input_mt_init_slots()
and input_register_device(), so it seems that we cannot solve this by calling
input_mt_destroy_slots() from the error path within input_register_device().

Maybe a better option is to update input_mt_init_slots() to use device-managed
allocation instead?

> 
> It should also be called in a .remove function (unless
> devm_add_action_or_reset is prefered)

I think the remove path is OK, as input_dev_release() handles this for us. In
case I have misunderstood, please let me know.

> 
> CJ
> 
> > +		dev_err(dev, "failed to register input device: %d\n", error);
> > +		return error;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> ...
> 

Kind regards,
Jeff LaBundy
