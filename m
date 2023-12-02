Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58153801A4B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 04:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjLBDxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 22:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjLBDxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 22:53:46 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F202D7E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 19:53:51 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c9ea37ac87so7308741fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 19:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701489229; x=1702094029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/X6pUB+0bQ56apBOdWN+1k7Q5/pfK+fu02ztx2gfwRI=;
        b=C6hdin+CUZ/dIZwrFSBeqAr0Olde15EpHb9MKSGNfjDJhDbgk2AQ/x5crr4QTKvLli
         jsqFrEQJ+HfJ9f5WQomDyhklhi7Sq1fsV7ZeapYxdaM+s6wwV/tVl4zjx4N9TiVlArtu
         2swKMcN6BGpKjNswGlZM1NBMxm9N2hn9muOiqgY3pZmIsD8qxMzG58Jj1hXucNntmTyD
         fshjVHyyuNOTCuFeYv3O1yKy6pefJUusPWJxycGNubrlvhLA3VnJqaYTHGWBPphLs6/3
         qnnzgYy88mNDDxaGKW+xT3tdSwy4362LDsjevPEI4YVBhvVCpi/hXMSbj+vGS2m5vqCR
         uTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701489229; x=1702094029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/X6pUB+0bQ56apBOdWN+1k7Q5/pfK+fu02ztx2gfwRI=;
        b=hbGg8awVWSqDJa19c05+O1u7Ji2qo2D9EBO82smXwlXiZ+q33bjYZXgpuaXcEmtuCT
         l42lLEG9uC8kHrwC905HpNubIyjGVczBklX7ND1GKCoqEnITHjnOLXzEsmu4ul7aoq/y
         o5jzQaaS4laxd5Yr/JxPGvghG1gynm/0i9o6Q8Vp2WEOR2fAPC3jypf41tW/kDyRRURN
         oRywWvtVl7zXh3FWk+0V/rCnA2JH7PqRrw9Afvv4h5xwpBVb35KtynA6i7hEVrVNYBiR
         5msZ9xLZ0Eb+Ueaof0UstIbB/aGMe8kt6ERRPtk5Lvt6TudrV2aH03aJaSSe2yd9fQF1
         H+kw==
X-Gm-Message-State: AOJu0YyL6MbGPD1Rio3M37zCXGx3pqDdup/r8leIlg4Jxl3vIBRkHWIk
        Wt67yG9427xzAPcTq9MFZzmO56Cxcw3frfVzsJhyOQ==
X-Google-Smtp-Source: AGHT+IHcabjOBJboo9/eAZ4gwHUN0UetxZ94RCEeqfp7HwrBwMkkoF8Z5uOglGL7srWnPeLju8p2oc4wWg2KmtnjBJQ=
X-Received: by 2002:a2e:9ec1:0:b0:2c9:d872:abdf with SMTP id
 h1-20020a2e9ec1000000b002c9d872abdfmr1118242ljk.93.1701489229229; Fri, 01 Dec
 2023 19:53:49 -0800 (PST)
MIME-Version: 1.0
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com> <CAMknhBH0pF_+z_JqWGscELBmAEDyxLAtgQ-j3=6P2MeFXnzhWQ@mail.gmail.com>
In-Reply-To: <CAMknhBH0pF_+z_JqWGscELBmAEDyxLAtgQ-j3=6P2MeFXnzhWQ@mail.gmail.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Fri, 1 Dec 2023 21:53:38 -0600
Message-ID: <CAMknhBEcEJ01nO0p5_vy4jVBVTL_rhEk+pvBpXdMtaDurc-05A@mail.gmail.com>
Subject: Re: [PATCH 00/12] iio: add new backend framework
To:     nuno.sa@analog.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 5:54=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >
> > Hi all,
> >
> > This is a Framework to handle complex IIO aggregate devices.
> >
> > The typical architecture is to have one device as the frontend device w=
hich
> > can be "linked" against one or multiple backend devices. All the IIO an=
d
> > userspace interface is expected to be registers/managed by the frontend
> > device which will callback into the backends when needed (to get/set
> > some configuration that it does not directly control).
> >
> > The basic framework interface is pretty simple:
> >  - Backends should register themselves with @devm_iio_backend_register(=
)
> >  - Frontend devices should get backends with @devm_iio_backend_get()
> >
> > (typical provider - consumer stuff)
> >
>
> The "typical provider - consumer stuff" seems pretty straight forward
> for finding and connecting two different devices, but the definition
> of what is a frontend and what is a backend seems a bit nebulous. It
> would be nice to seem some example devicetree to be able to get a
> better picture of how this will be used in practices (links to the the
> hardware docs for those examples would be nice too).
>

Fulfilling my own request here...

Since AD9467 is being use as the example first user of the IIO offload fram=
ework
I did a deep dive into how it is actually being used. It looks like this:

---------------------------------------------------------------------------=
-
Hardware
---------------------------------------------------------------------------=
-

AD9467
------

High-speed ADC that uses SPI for configuration and LVDS for data capture.

https://www.analog.com/media/en/technical-documentation/data-sheets/AD9467.=
pdf

Pins:

    Supplies:
    - AVDD1 (1.8V analog supply)
    - AVDD2 (3.3V analog supply)
    - AVDD3 (1.8V analog supply)
    - SPIVDD (1.8V or 3.3V SPI supply)
    - DRVDD (1.8V digital output driver supply)
    - XVREF (optional reference voltage)

    SPI:
    - CSB
    - SDIO
    - SCLK

    Analog input:
    - VIN+/VIN-

    Clock input:
    - CLK+/CLK-

    Digital output:
    - Dn-/Dn+ (parallel digital output)
    - DCO+/DCO- (data clock output)
    - OR+/OR- (out of range output)


ADI AXI ADC
-----------

FPGA IP core for interfacing an ADC device with a high speed serial (JESD20=
4B)
or source synchronous parallel interface (LVDS/CMOS).

https://wiki.analog.com/resources/fpga/docs/axi_adc_ip

Interfaces:

    LVDS:
    - rx_clk_in_[p|n]   clock input
    - rx_data_in_[p|n]  parallel data input
    - rx_frame_in_[p|n] frame input signal (optional/device specific)
    - rx_or_in_[p|n]    over range input (optional/device specific)

    Write FIFO:
    - see link for details, this consists of multiple signals that connect =
to a
      "sink module"

    MMIO:
    - memory mapped registers (detailed in link)


"sink module"
-------------

FPGA IP core for piping a data stream to DMA.

https://wiki.analog.com/resources/fpga/docs/util_var_fifo

Interfaces:

    Data Input:
    - data_in           Data to be stored
    - data_in_valid     Valid for the input data

    Data Output:
    - data_out          Data forwarded to the DMA
    - data_out_valid    Valid for the output data

    There are additional interfaces but they probably don't concern devicet=
ree
    since software doesn't interact with them (AFAIK).


Schematic
---------

+----------------------------+    +---------------+    +-------------------=
+
| SOC/FPGA                   |    | ADC           |    | Signal generator  =
|
|                            |    |               |    |                   =
|
|  +--------------------+    |    |       VIN+/- xxxxxxxx VOUT+/-          =
|
|  | SPI                |    |    |               |    |                   =
|
|  |               SDIO ------------ SDIO         |    +-------------------=
+
|  |               SCLK ------------ SCLK         |
|  |                 CS ------------ CSB          |    +-------------------=
+
|  |                    |    |    |               |    | External clock    =
|
|  +--------------------+    |    |               |    |                   =
|
|  | AXI ADC            |    |    |      CLK+/- xxxxxxxxx CLKOUT+/-        =
|
|  |                    |    |    |               |    |                   =
|
|  |  rx_data_in_[p|n] xxxxxxxxxxxxx Dn+/-        |    +-------------------=
+
|  |   rx_clk_in_[p|n] xxxxxxxxxxxxx DCO+/DCO-    |
|  |    rx_or_in_[p|n] xxxxxxxxxxxxx OR+/-        |    +-------------------=
+
|  |                    |    |    |               |    | Power supplies    =
|
|  |        Write FIFO =3D=3D=3D#  |    |               |    |             =
      |
|  +--------------------+ H  |    |        AVDD1 --------- 1.8V            =
|
|  | "sink module"      | H  |    |        AVDD2 --------- 2.2V            =
|
|  |                    | H  |    |        AVDD3 --------- 1.8V            =
|
|  |        Data Input =3D=3D=3D#  |    |       SPIVDD --------- 3.3V      =
      |
|  |                    |    |    |        DRVDD --------- 1.8V            =
|
|  |       Data Output =3D=3D=3D#  |    |        XVREF --------- 1.2V      =
      |
|  +--------------------+ H  |    |               |    |                   =
|
|  | DMA controller     | H  |    +---------------+    +-------------------=
+
|  |                    | H  |
|  |         channel 0 =3D=3D=3D#  |
|  |                    |    |
|  +--------------------+    |
|                            |
+----------------------------+

---------------------------------------------------------------------------=
-
Devicetree
---------------------------------------------------------------------------=
-

Current situation:

&soc: {
    spi {
        ...

        spi_adc: adc@0 {
            compatible =3D "adi,ad9467";
            reg =3D <0>;
            clocks =3D <&adc_clk>;
            clock-names =3D "adc-clk";
        };
    };

    fpga {
        ...

        /* IIO device is associated with this node. */
        axi-adc@44a00000 {
            compatible =3D "adi,axi-adc-10.0.a";
            reg =3D <0x44a00000 0x10000>;
            /* Not sure dmas belong here since it is a property of the
             * "sink module" which is separate from AXI ADC module. */
            dmas =3D <&rx_dma 0>;
            dma-names =3D "rx";

            adi,adc-dev =3D <&spi_adc>;
        };
    };
};

---

Proposed IIO backend framework (inferred from v1 patches):

&soc: {
    spi {
        ...

        /* IIO device is associated with this node. */
        adc@0 {
            compatible =3D "adi,ad9467";
            reg =3D <0>;
            clocks =3D <&adc_clk>;
            clock-names =3D "adc-clk";
            /* As discussed already, this isn't really the right place for
             * dmas either. */
            dmas =3D <&rx_dma 0>;
            dma-names =3D "rx";

            io-backends =3D <&axi_adc>;
        };
    };

    fpga {
        ...

        axi_adc: axi-adc@44a00000 {
            compatible =3D "adi,axi-adc-10.0.a";
            reg =3D <0x44a00000 0x10000>;
        };
    };
};

---

Composite device?

/* IIO device is associated with this node. */
adc {
    compatible =3D "adi,ad9467";

    io-backends =3D <&adc_spi_backend>, <&adc_lvds_backend>;

    clocks =3D <&adc_clk>;
    clock-names =3D "adc-clk";

    xvref-supply =3D <&ref_voltage>;
    avdd1-supply =3D <&regulator_1_8V>;
    avdd2-supply =3D <&regulator_3_3V>;
    avdd3-supply =3D <&regulator_1_8V>;
};

&soc: {
    spi {
        ...

        /* This node describes only the SPI aspects of the ADC chip */
        adc_spi_backend: adc@0 {
            compatible =3D "adi,ad9467-spi-io-backend";
            reg =3D <0>;

            spi-3wire;
            spi-max-frequency =3D <25000000>;

            spivdd-supply =3D <&regulator_1_8V>;
        };
    };

    fpga {
        ...

        /* This node is an LVDS bus, analogous to a SPI bus or I2C bus */
        axi-adc@44a00000 {
            compatible =3D "adi,axi-adc-10.0.a";
            reg =3D <0x44a00000 0x10000>;

            ...

            /* This node describes all sink modules that are connected to
             * the AXI ADC controller through the FPGA fabric. */
            sink-modules {
                ...

                /* This node describes the FIFO to DMA sink module used by
                 * our ADC. */
                adc_dma: module@0 {
                    compatible =3D "adi,dma-fifo-1.0.a";
                    reg =3D <0>;

                    dmas =3D <&rx_dma 0>;
                    dma-names =3D "rx";
                };
            };

            /* Then we describe what is connected to each channel of the
             * controller (reg =3D=3D channel number). */

            /* This node describes only the digital output (LVDS) aspects o=
f
            * the ADC chip */
            adc_lvds_backend: adc@0 {
                compatible =3D "adi,ad9467-lvds-io-backend";
                reg =3D <0>;

                drvdd-supply =3D <&regulator_1_8V>;

                /* This is a LVDS bus peripheral property that can only be =
used
                 * with peripheral nodes that are children of a compatible =
=3D
                 * "adi,axi-adc-10.0.a" node. This works exactly like the
                 * controller-specific SPI bus peripheral properties, e.g.
                 * like samsung,spi-peripheral-props.yaml. */
                adi,sink-modules =3D <&adc_dma>;
            }
        };
    };
};


---------------------------------------------------------------------------=
-
Discussion
---------------------------------------------------------------------------=
-

After reviewing the existing device tree bindings, it appears the current
adi,ad9467.yaml is incomplete. It lacks the supplies and even though the
example shows that it is a child of a spi node, it is missing a reference t=
o
/schemas/spi/spi-peripheral-props.yaml# and spi properties like spi-3wire
and spi-max-frequency. It also misses a description of what is connected to
the digital output, but that I think that is the main thing we are trying t=
o
solve here - if it belongs there or somewhere else.

Having read more about the AXI ADC IP block, it seems to me like it should =
just
be considered an LVDS bus controller with generic bindings similar to how w=
e
have SPI and I2C buses.

Following that line of thought, if the compatible =3D "adi,axi-adc-10.0.a" =
node
is a bus node, then logically, the ADC device node should be a child node o=
f
that LVDS bus node. But since the ADC is also a SPI device it also needs to
be a child node of the SPI bus node. But is can't be a child of two differe=
nt
nodes, so where does it go?

This is where the IIO backend framework can come in. We can create a "compo=
site"
device as seen in the example dts above. This is just a platform device (in
Linux-speak) and it composes the two "io-backend" devices from the the two
busses to create a logical iio/adc device.

To solve the mystery of "where does the dmas property belong?", I have take=
n
a page out of the work I am preparing the AXI SPI Engine offload support [1=
].
(This hasn't been submitted to a mailing list yet because I'm still working
on the driver, but the bindings are finished and I ran the idea by Rob on I=
RC
a while back who suggested doing it this way, so maybe it works here too?)

[1]: https://github.com/analogdevicesinc/linux/pull/2341/commits/57bb199837=
1f61f4144689136aba5dd6d16a2a66

Since the "sink module" is really a separate IP block from the AXI ADC, it =
gets
its own node and compatible string. Since these "sink modules" are connecte=
d to
the AXI ADC, they get listed as child nodes, but we group them together und=
er a
single sink-modules node to separate them from the LVDS peripherals nodes. =
Then
they get associated with a peripheral with the adi,sink-modules property (a=
lso
see comment on that property in the example above).

My "composite" device example evolved quite a bit as I was writing this but=
 I'm
pretty happy with where it ended up. I think adding child nodes to the axi-=
adc
node answers Nuno's concerns about how to keep a generic axi-adc binding wh=
ile
accounting for the fact that it changes slightly depending on what it is
attached to. And having a separate platform device solves my questions abou=
t
the ambiguity of which should be the front end, the spi node or the axi-adc
node. It turns out, perhaps the answer is neither.
